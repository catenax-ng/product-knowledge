//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.ws.rs.core.HttpHeaders;
import jakarta.ws.rs.core.Request;
import jakarta.ws.rs.core.Response;
import org.eclipse.edc.spi.monitor.Monitor;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Utilities to deal with Http Protocol stuff
 */
public class HttpUtils {

    public static String DEFAULT_CHARSET= StandardCharsets.US_ASCII.name();
    public static String DEFAULT_ENCODING = System.getProperty("fis.encoding","UTF-8");

    /**
     * ensure that the given parameter string is correctly
     * encoded
     * TODO optimize
     * @param parameter maybe undecoded parameter
     * @return a url encoded string which additionally encodes some URL-prefix related symbols
     */
    public static String urlEncodeParameter(String parameter) throws UnsupportedEncodingException {
        if(parameter==null || parameter.length()==0) return "";
        return encodeParameter(URLEncoder.encode(URLDecoder.decode(parameter,DEFAULT_ENCODING),DEFAULT_ENCODING));
    }

    /**
     * ensure that the given parameter string is correctly
     * encoded
     * TODO optimize
     * @param parameter maybe undecoded parameter
     * @return a url encoded string which additionally encodes some URL-prefix related symbols
     */
    public static String encodeParameter(String parameter) throws UnsupportedEncodingException {
        if(parameter==null || parameter.length()==0) return "";
        return parameter.replace("?","%3F")
                .replace("{","%7B")
                .replace("}","%7D")
                .replace("/","%2F");
    }

    /**
     * creates a response from a given setting
     * depending on the accept type
     * @param monitor logging system to save the reference error
     * @param headers of the request
     * @param message error message
     * @param cause error object
     * @return http response with the right body and reference to the logging subsystem
     */
    public static Response respond(Monitor monitor, HttpHeaders headers, int status, String message, Throwable cause) {
        int messageCode=message.hashCode();
        if(monitor!=null) {
            if(cause!=null) {
                monitor.warning(String.format("Response with error id %d delivered message %s under cause %s", messageCode, message, cause.getMessage()),cause);
            } else {
                monitor.warning(String.format("Response with error id %d delivered message %s", messageCode, message));
            }
        }
        var builder = Response.status(status);
        String accept=headers.getHeaderString("Accept");
        if(accept==null || accept.length()==0 ) {
            accept="*/*";
        }
        if(accept.contains("*/*")) {
            accept="application/json";
        }
        if(accept.contains("application/json")) {
            builder.type("application/json");
            builder.entity("{ " +
                    "\"status\":" + String.valueOf(status) + "," +
                    "\"message\":\"" + messageCode + "\" }");
        } else if(accept.contains("text/xml") || accept.contains("application/xml")) {
            builder.type(accept.contains("text/xml") ? "text/xml" : "application/xml");
            builder.entity("<failure> " +
                    "<status>" + String.valueOf(status) + "</status>" +
                    "<message>" + messageCode + "</message> </failure>");
        } else if(accept.contains("text/html")) {
            builder.type("text/html");
            builder.entity("<!DOCTYPE html>\n" +
                    "<html>\n" +
                    "<head>\n" +
                    "  <title>Agent Subsystem Error</title>\n" +
                    "</head>\n" +
                    "<body>\n" +
                    "\n" +
                    "<h1>An Problem has occured in the Catena-X Agent subsystem.</h1>\n" +
                    "<p> Status: " + String.valueOf(status) + "</p>\n" +
                    "<p>" + messageCode + "</p>\n" +
                    "\n" +
                    "</body>\n" +
                    "</html>");
        } else {
            builder.type("text/plain");
            builder.entity(messageCode);
        }
        return builder.build();
     }
}
