/*
 *  Copyright (c) 2021 T-Systems International GmbH
 *
 *  This program and the accompanying materials are made available under the
 *  terms of the Apache License, Version 2.0 which is available at
 *  https://www.apache.org/licenses/LICENSE-2.0
 *
 *  SPDX-License-Identifier: Apache-2.0
 *
 *  Contributors:
 *       T-Systems International GmbH - initial API and implementation
 *
 */

package net.catenax.semantics.sparql;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataMultiPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

import java.io.InputStream;
import java.io.IOException;

import okhttp3.OkHttpClient;
import okhttp3.RequestBody;
import okhttp3.Request;

@Path("/sparql")
public class SparqlController {

    private final Monitor monitor;
    private final String delegateEndpoint;

    public SparqlController(Monitor monitor, String delegateEndpoint) {
        this.monitor = monitor;
        this.delegateEndpoint = delegateEndpoint;
    }

    /**
     * A get call is done when the query is not too complicated.
     *
     * @param compartment
     * @param payload
     * @return response
     */
    @GET
    @Path("{compartment: [a-zA-Z0-9_/\\-]+}")
    public Response get(
            @PathParam("compartment") String compartment,
            @QueryParam("query") String payload
    ) {
        return process(compartment, payload);
    }

    /**
     * a post call is done when the query becomes too large
     *
     * @param compartment
     * @param payload
     * @return response
     */
    @POST
    @Path("{compartment: [a-zA-Z0-9_/\\-]+}")
    @Consumes({"application/sparql-query"})
    @Produces({MediaType.APPLICATION_XML})
    public Response post(
            @PathParam("compartment") String compartment,
            //@FormDataParam("header") InputStream headerInputStream,
            //@FormDataParam("payload") String payload
            String payload
    ) {
        return process(compartment, payload);
    }

    /**
     * the actual processing (no matter the method)
     *
     * @param compartment
     * @param payload
     * @return response
     */
    protected Response process(String compartment, String payload) {
        monitor.info("Received a sparql query to compartment " + compartment);
        OkHttpClient httpClient = new OkHttpClient();
        // form parameters
        okhttp3.MediaType mediaType = okhttp3.MediaType.parse("application/sparql-query");
        RequestBody formBody = RequestBody.create(mediaType, payload);
        String finalEndpoint = String.format(delegateEndpoint, compartment);

        monitor.debug(payload);

        monitor.info("Delegating request to internal SPARQL service " + finalEndpoint);

        Request request = new Request.Builder()
                .url(finalEndpoint)
                .post(formBody)
                .build();

        try (okhttp3.Response response = httpClient.newCall(request).execute()) {

            if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

            // Get response body
            String responseBody = response.body().string();
            System.out.println(responseBody);
            return Response.ok(responseBody, MediaType.APPLICATION_XML).build();
        } catch (Exception e) {
            e.printStackTrace();
            return Response.status(Response.Status.NOT_FOUND).build();
        }
    }
}
