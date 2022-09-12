//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

/**
 * Utilities to deal with Http Protocol stuff
 */
public class HttpUtils {

    public static String DEFAULT_CHARSET= StandardCharsets.US_ASCII.name();

    /**
     * ensure that the given parameter string is correctly
     * encoded
     * TODO optimize
     * @param parameter maybe undecoded parameter
     * @return a url encoded string which additionally encodes some URL-prefix related symbols
     */
    public static String urlEncodeParameter(String parameter) throws UnsupportedEncodingException {
        if(parameter==null || parameter.length()==0) return parameter;
        return encodeParameter(URLEncoder.encode(URLDecoder.decode(parameter)));
    }

    /**
     * ensure that the given parameter string is correctly
     * encoded
     * TODO optimize
     * @param parameter maybe undecoded parameter
     * @return a url encoded string which additionally encodes some URL-prefix related symbols
     */
    public static String encodeParameter(String parameter) throws UnsupportedEncodingException {
        if(parameter==null || parameter.length()==0) return parameter;
        return parameter.replace("?","%3F")
                .replace("{","%7B")
                .replace("}","%7D")
                .replace("*","%2A")
                .replace("/","%2F");
    }
}
