package net.catenax.semantics.sparql;

import jakarta.ws.rs.Consumes;
import jakarta.ws.rs.POST;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.Produces;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.dataspaceconnector.spi.monitor.Monitor;
import org.glassfish.jersey.media.multipart.FormDataBodyPart;
import org.glassfish.jersey.media.multipart.FormDataMultiPart;
import org.glassfish.jersey.media.multipart.FormDataParam;

import java.io.InputStream;

@Path("/sparql")
@Consumes({MediaType.MULTIPART_FORM_DATA})
@Produces({MediaType.APPLICATION_JSON})
public class SparqlController {

    private final Monitor monitor;

    public SparqlController(Monitor monitor) {
        this.monitor = monitor;
    }

    @POST
    public Response request(
            @FormDataParam("header") InputStream headerInputStream,
            @FormDataParam("payload") String payload) {
        monitor.info("Received a sparql query");
        return Response.ok("I'm alive",MediaType.APPLICATION_JSON).build();
    }
}
