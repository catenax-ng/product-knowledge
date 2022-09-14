//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import okhttp3.Response;
import okhttp3.ResponseBody;

import javax.net.ssl.SSLSession;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpHeaders;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Optional;

/**
 * wraps OkHttp Response to java.net.http version
 */
public class HttpResponseWrapper implements HttpResponse<InputStream> {

    Response delegate;
    HttpHeaders headers;
    HttpRequest request;

    public HttpResponseWrapper(Response delegate, HttpRequest request) {
        this.delegate=delegate;
        this.request=request;
        headers=HttpHeaders.of(delegate.headers().toMultimap(), (key,value)->true);
    }

    @Override
    public int statusCode() {
        return delegate.code();
    }

    @Override
    public HttpRequest request() {
        return request;
    }

    @Override
    public Optional<HttpResponse<InputStream>> previousResponse() {
        return Optional.empty();
    }

    @Override
    public HttpHeaders headers() {
        return headers;
    }

    @Override
    public InputStream body() {
        ResponseBody body=delegate.body();
        if(body!=null) {
           return body.byteStream();
        }
        return null;
    }

    @Override
    public Optional<SSLSession> sslSession() {
        return Optional.empty();
    }

    @Override
    public URI uri() {
        return request.uri();
    }

    @Override
    public HttpClient.Version version() {
        return HttpClient.Version.HTTP_1_1;
    }
}
