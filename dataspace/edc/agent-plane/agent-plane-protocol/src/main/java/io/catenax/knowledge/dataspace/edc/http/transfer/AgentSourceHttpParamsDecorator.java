package io.catenax.knowledge.dataspace.edc.http.transfer;

import io.catenax.knowledge.dataspace.edc.AgentConfig;
import org.eclipse.edc.connector.dataplane.http.spi.HttpParamsDecorator;
import org.eclipse.edc.connector.dataplane.http.spi.HttpRequestParams;
import org.eclipse.edc.spi.EdcException;
import org.eclipse.edc.spi.monitor.Monitor;
import org.eclipse.edc.spi.types.domain.HttpDataAddress;
import org.eclipse.edc.spi.types.domain.transfer.DataFlowRequest;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * Decorator to implement specifics of the http-based Agent transfer protocol.
 * In particular the translation back from transfer to matchmaking.
 * should be placed instead of {@see org.eclipse.edc.connector.dataplane.http.params.decorators.BaseSourceHttpParamsDecorator}
 */
public class AgentSourceHttpParamsDecorator implements HttpParamsDecorator {

    /**
     * static constants
     */
    public static String ASSET_PROP_ID="asset:prop:id";
    public static String QUERY_PARAMS="queryParams";
    public static String ACCEPT_HEADER="Accept";
    public static String METHOD="method";
    public static String DEFAULT_METHOD="GET";
    public static String HOST_HEADER="Host";
    public static String PATH_SEGMENTS="pathSegments";
    public static String BASE_URL="baseUrl";
    public static String BODY="body";
    public static String MEDIA_TYPE="mediaType";
    public static String SLASH="/";

    public static String CX_ACCEPT_PARAM="cx_accept";

    public static String DEFAULT_ACCEPT="*/*";
    /**
     * regexes to extract url-encoded form and query parts
     */
    public static Pattern PARAMS = Pattern.compile("(?<param>[^=&]+)=(?<value>[^&]*)");

    /**
     * service references
     */
    final protected AgentConfig config;
    final protected Monitor monitor;

    /**
     * creates a new decorator
     * @param config agent configuration
     * @param monitor logging facility
     */
    public AgentSourceHttpParamsDecorator(AgentConfig config, Monitor monitor) {
        this.config=config;
        this.monitor=monitor;
    }

    /**
     * check whether this is a transfer or a source request
     * @param dataflowRequest
     * @return if this is a transfer request
     */
    public static boolean isTransferRequest(DataFlowRequest dataflowRequest) {
        return dataflowRequest.getSourceDataAddress().getProperties().getOrDefault(ASSET_PROP_ID, null)==null;
    }

    /**
     * parse the body or parameter string as a url-encoded form into a map
     * @param body url-encoded form body
     * @return a map of parameters
     */
    public static Map<String, List<String>> parseParams(String body) {
        Map<String,List<String>> parts=new HashMap<>();
        if(body!=null) {
            Matcher matcher=PARAMS.matcher(body);
            while(matcher.find()) {
                String paramName=matcher.group("param");
                List<String> partSet=parts.get(paramName);
                if(partSet==null) {
                    partSet=new ArrayList<>();
                    parts.put(paramName,partSet);
                }
                partSet.add(matcher.group("value"));
            }
        }
        return parts;
    }

    public static Map<String, List<String>> mergeParams(Map<String, List<String>> param1, Map<String, List<String>> param2) {
        param2.forEach( (key,value) -> {
            if(param1.containsKey(key)) {
                param1.get(key).addAll(value);
            } else {
                param1.put(key,value);
            }
        });
        return param1;
    }

    /**
     * Implements the decoration
     * @param request transfer request (contains dynamic stuff)
     * @param address target address (contains static stuff)
     * @param params translated call content (up to now)
     * @return translated call content (identical to params)
     */
    @Override
    public HttpRequestParams.Builder decorate(DataFlowRequest request, HttpDataAddress address, HttpRequestParams.Builder params) {
        String contentType=this.extractContentType(address, request);
        String body= this.extractBody(address,request);
        Map<String,List<String>> queryParams=parseParams(getRequestQueryParams(address,request));

        if(isTransferRequest(request)) {
            if(!address.getProperty(BASE_URL).endsWith(SLASH)) {
                params.baseUrl(address.getProperty(BASE_URL)+SLASH);
            }
        } else {
            // there is the case where a KA-BIND protocol call is
            // one-to-one routed through the transfer plane ... in which case
            // we may get query parameters in the body
            // in this case we leave the query in the body (and rewriting the content type)
            if (contentType != null && contentType.contains("application/x-www-form-urlencoded")) {
                Map<String,List<String>> bodyParams=parseParams(body);
                contentType="application/sparql-query";
                List<String> queries=queryParams.getOrDefault("query",bodyParams.getOrDefault("query",List.of()));
                if(queries.size()!=1) {
                    new EdcException(String.format("DataFlowRequest %s: found %d queries when contentType application/x-www-form-urlencoded is used", request.getId(),queries.size()));
                }
                body=URLDecoder.decode(queries.get(0), StandardCharsets.UTF_8);
                bodyParams.remove("query");
                queryParams.remove("query");
                queryParams=mergeParams(queryParams,bodyParams);
            }
            boolean fixedHost = address.getProperty(HttpDataAddress.ADDITIONAL_HEADER + HOST_HEADER) != null;
            if (!fixedHost) {
                try {
                    URL controlPlane = new URL(config.getControlPlaneManagementUrl());
                    String hostPart = controlPlane.getHost();
                    int portPart = controlPlane.getPort();
                    String host = String.format("%s:%d", hostPart, portPart);
                    params.header(HOST_HEADER, host);
                } catch (MalformedURLException e) {
                    // TODO log problem
                }
            }
            boolean fixedAccept=address.getProperty(HttpDataAddress.ADDITIONAL_HEADER+HOST_HEADER)!=null;
            List<String> cxAccepts=queryParams.getOrDefault(CX_ACCEPT_PARAM,List.of());
            queryParams.remove(CX_ACCEPT_PARAM);
            if(!fixedAccept) {
                String accept=DEFAULT_ACCEPT;
                for(String newAccept : cxAccepts) {
                    accept = newAccept.replace("q=[0-9]+(\\.[0-9]+)?, ", "").replace("%2F", "/");
                };
                params.header(ACCEPT_HEADER,accept);
            }
        }
        Map<String,List<String>> addressParams=parseParams(address.getQueryParams());
        queryParams=mergeParams(queryParams,addressParams);
        String paramString=queryParams.entrySet().stream().flatMap((param) -> {
            return param.getValue().stream().map( (value) -> {
                return param.getKey()+"="+value;
            });
        }).collect(Collectors.joining("&"));
        params.queryParams(!paramString.isEmpty() ? paramString : null);
        params.method(this.extractMethod(address, request));
        params.path(this.extractPath(address, request));
        params.contentType(contentType);
        params.body(body);
        params.nonChunkedTransfer(false);
        return params;
    }

    protected @NotNull String extractMethod(HttpDataAddress address, DataFlowRequest request) {
        return Boolean.parseBoolean(address.getProxyMethod()) ? (String)Optional.ofNullable((String)request.getProperties().get(METHOD)).orElseThrow(() -> {
            return new EdcException(String.format("DataFlowRequest %s: 'method' property is missing", request.getId()));
        }) : (String)Optional.ofNullable(address.getMethod()).orElse(DEFAULT_METHOD);
    }

    protected @Nullable String extractPath(HttpDataAddress address, DataFlowRequest request) {
        return Boolean.parseBoolean(address.getProxyPath()) ? (String)request.getProperties().get(PATH_SEGMENTS) : address.getPath();
    }

    protected @Nullable String getRequestQueryParams(HttpDataAddress address, DataFlowRequest request) {
        return Boolean.parseBoolean(address.getProxyQueryParams()) ? (String)request.getProperties().get(QUERY_PARAMS) : null;
    }

    /**
     * extract the content type
     * @param address target address
     * @param request data flow request
     * @return the content type (which would be derived from the query language part in case the original content type is a url-encoded form)
     */
    protected @Nullable String extractContentType(HttpDataAddress address, DataFlowRequest request) {
        String contentType = Boolean.parseBoolean(address.getProxyBody()) ? (String)request.getProperties().get(MEDIA_TYPE) : address.getContentType();
        return contentType;
    }

    protected @Nullable String extractBody(HttpDataAddress address, DataFlowRequest request) {
        return Boolean.parseBoolean(address.getProxyBody()) ? (String)request.getProperties().get(BODY) : null;
    }
}
