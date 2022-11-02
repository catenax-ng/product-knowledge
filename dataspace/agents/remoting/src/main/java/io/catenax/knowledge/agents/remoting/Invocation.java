//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.StringWriter;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.node.ArrayNode;
import org.apache.http.Header;
import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.eclipse.rdf4j.model.IRI;
import org.eclipse.rdf4j.model.Literal;
import org.eclipse.rdf4j.model.Value;
import org.eclipse.rdf4j.model.ValueFactory;
import org.eclipse.rdf4j.query.algebra.Var;
import org.eclipse.rdf4j.sail.SailException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

/**
 * Implements a (batch) invocation and represents an instance of the rdf:type cx-fx:Function
 * One function/invocation binding may result in several invocations as being
 * determined by the batch size of the config.
 * Invocation targets can be local java objects or remote REST services.
 */
@SuppressWarnings("ALL")
public class Invocation {

    protected static Logger logger = LoggerFactory.getLogger(Invocation.class);

    /** the config of the service invoked */
    public InvocationConfig service = null;
    /** unique key for the invocation */
    public IRI key = null;
    /** start time */
    public long startTime = -1;
    /** end time of the invocation */
    public long endTime = -1;
    /** success code */
    public int success = 0;
    /** input bindings */
    public Map<IRI, Value> inputs = new HashMap<>();
    /** output bindings */
    public Map<Var, IRI> outputs = new HashMap<>();
    /** the actual result as a value */
    public Object result = null;

    public static ObjectMapper objectMapper=new ObjectMapper();
    public static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.sss'Z'");

    static {
        objectMapper.setDateFormat(df);
        objectMapper.disable(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS);
    }

    /**
     * converter from the literal to the type system
     */
    public <Target> Target convertToObject(Value binding, Class<Target> target) throws SailException {
        if (target.isAssignableFrom(String.class)) {
            return (Target) binding.stringValue();
        } else if (target.isAssignableFrom(int.class)) {
            try {
                return (Target) Integer.valueOf(Integer.parseInt(binding.stringValue()));
            } catch(NumberFormatException nfe) {
                throw new SailException(String.format("Conversion from %s to %s failed.", binding, target), nfe);
            }
        } else if (target.isAssignableFrom(long.class)) {
            try {
                return (Target) Long.valueOf(Long.parseLong(binding.stringValue()));
            } catch(NumberFormatException nfe) {
                throw new SailException(String.format("Conversion from %s to %s failed.", binding, target), nfe);
            }
        } else if (target.isAssignableFrom(double.class)) {
            try {
                return (Target) Double.valueOf(Double.parseDouble(binding.stringValue()));
            } catch(NumberFormatException nfe) {
                throw new SailException(String.format("Conversion from %s to %s failed.", binding, target), nfe);
            }
        } else if (target.isAssignableFrom(float.class)) {
            try {
                return (Target) Float.valueOf(Float.parseFloat(binding.stringValue()));
            } catch(NumberFormatException nfe) {
                throw new SailException(String.format("Conversion from %s to %s failed.", binding, target), nfe);
            }
        } else if (target.isAssignableFrom(JsonNode.class)) {
            if(binding.isLiteral()) {
                IRI dataType=((Literal) binding).getDatatype();
                String dataTypeName=dataType.stringValue();
                switch(dataTypeName) {
                    case "http://www.w3.org/2001/XMLSchema#string":
                        return (Target) objectMapper.getNodeFactory().textNode(binding.stringValue());
                    case "http://www.w3.org/2001/XMLSchema#int":
                        return (Target) objectMapper.getNodeFactory().numberNode(Integer.valueOf(binding.stringValue()));
                    case "http://www.w3.org/2001/XMLSchema#long":
                        return (Target) objectMapper.getNodeFactory().numberNode(Long.valueOf(binding.stringValue()));
                    case "http://www.w3.org/2001/XMLSchema#double":
                        return (Target) objectMapper.getNodeFactory().numberNode(Double.valueOf(binding.stringValue()));
                    case "http://www.w3.org/2001/XMLSchema#float":
                        return (Target) objectMapper.getNodeFactory().numberNode(Float.valueOf(binding.stringValue()));
                    case "http://www.w3.org/2001/XMLSchema#dateTime":
                        try {
                            return (Target) objectMapper.getNodeFactory().textNode(df.format(df.parse(binding.stringValue())));
                        } catch(ParseException pe) {
                            throw new SailException(String.format("Could not convert %s of to json date.", binding),pe);
                        }
                    case "https://json-schema.org/draft/2020-12/schema#Object":
                        try {
                            return (Target) objectMapper.readTree(binding.stringValue());
                        } catch(JsonProcessingException jpe) {
                            throw new SailException(String.format("Could not convert %s of to json object.", binding),jpe);
                        }
                    default:
                        throw new SailException(String.format("Could not convert %s of data type %s integer.", binding,dataTypeName));
                }
            } else if(binding.isIRI()) {
                return (Target) objectMapper.getNodeFactory().textNode(binding.stringValue());
            } else {
                throw new SailException(String.format("Could not convert %s.", binding));
            }
        }
        throw new SailException(String.format("No conversion from %s to %s possible.", binding, target));
    }

    @Override
    public String toString() {
        return super.toString()+"/invocation";
    }

    /**
     * traverse path
     * 
     * @param source
     * @return path object
     */
    public Object traversePath(Object source, String... path) throws SailException {
        if (logger.isTraceEnabled()) {
            logger.trace(String.format("Accessing a path of length %d under %s", path.length, source));
        }
        for (String elem : path) {
            if (elem != null && elem.length() > 0) {
                if (source instanceof Element) {
                    Element element = (Element) source;
                    if (element.hasAttribute(elem)) {
                        source = element.getAttribute(elem);
                    } else {
                        NodeList nl = element.getElementsByTagName(elem);
                        if (!(nl.getLength() > 0)) {
                            throw new SailException(String.format("No such path %s under object %s", elem, source));
                        }
                        source = nl.item(0);
                    }
                } else if (source instanceof JsonNode) {
                    JsonNode node = (JsonNode) source;
                    if (!node.has(elem)) {
                        throw new SailException(String.format("No such path %s under object %s", elem, source));
                    }
                    source = node.get(elem);
                } else {
                    throw new SailException(String.format("Cannot access path %s under object %s", elem, source));
                }
            }
        }
        return source;
    }

    public String convertObjectToString(Object source) throws SailException {
        if(source instanceof JsonNode) {
            JsonNode node=(JsonNode) source;
            if (node.isNumber() || node.isTextual()) {
                return node.asText();
            } else {
                try {
                    return objectMapper.writeValueAsString(node);
                } catch(JsonProcessingException jpe) {
                    throw new SailException(jpe);
                }
            }
        } else if(source instanceof Element) {
            TransformerFactory transFactory = TransformerFactory.newInstance();
            try {
                Transformer transformer = transFactory.newTransformer();
                StringWriter buffer = new StringWriter();
                transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
                transformer.transform(new DOMSource((Element) source), new StreamResult(buffer));
                return buffer.toString();
            } catch (TransformerException e) {
                throw new SailException(e);
            }
        } else {
            return String.valueOf(source);
        }
    }

    /**
     * converter from the literal to the type system
     */
    public Value convertOutputToValue(ValueFactory vf, String resultKey, IRI output) throws SailException {
        ReturnValueConfig cf = service.result.outputs.get(output.stringValue());
        if (cf == null) {
            throw new SailException(String.format("No output specification for %s", output));
        }
        Object target=result;
        if(service.result.outputProperty!=null) {
            target=traversePath(target,service.result.outputProperty);
        }
        if(resultKey!=null && resultKey.length()>0) {
            if(target.getClass().isArray()) {
                target=Array.get(target,Integer.parseInt(resultKey));
            } else if(target instanceof ArrayNode) {
                target=((ArrayNode) target).get(Integer.parseInt(resultKey));
            } else if(target instanceof Element){
                target=((Element) target).getChildNodes().item(Integer.parseInt(resultKey));
            }
        }
        String[] path = new String[0];
        if (cf.path != null) {
            path = cf.path.split("\\.");
        }
        Object pathObj = traversePath(target, path);
        switch (cf.dataType) {
            case "https://json-schema.org/draft/2020-12/schema#Object":
                return vf.createLiteral(convertObjectToString(pathObj),vf.createIRI("https://json-schema.org/draft/2020-12/schema#Object"));
            case "http://www.w3.org/2001/XMLSchema#dateTime":
                return vf.createLiteral(convertObjectToString(pathObj),vf.createIRI("http://www.w3.org/2001/XMLSchema#dateTime"));
            case "http://www.w3.org/2001/XMLSchema#int":
                try {
                    return vf.createLiteral(Integer.parseInt(convertObjectToString(pathObj)));
                } catch(NumberFormatException nfwe) {
                    throw new SailException(String.format("Could not convert %s to integer.", String.valueOf(pathObj)));
                }
            case "http://www.w3.org/2001/XMLSchema#long":
                try {
                    return vf.createLiteral(Long.parseLong(convertObjectToString(pathObj)));
                } catch(NumberFormatException nfwe) {
                    throw new SailException(String.format("Could not convert %s to integer.", String.valueOf(pathObj)));
                }
            case "http://www.w3.org/2001/XMLSchema#double":
                try {
                    return vf.createLiteral(Double.parseDouble(convertObjectToString(pathObj)));
                } catch(NumberFormatException nfwe) {
                    throw new SailException(String.format("Could not convert %s to integer.", String.valueOf(pathObj)));
                }
            case "http://www.w3.org/2001/XMLSchema#string":
                return vf.createLiteral(convertObjectToString(pathObj));
            case "http://www.w3.org/2001/XMLSchema#Element":
                return vf.createLiteral(convertObjectToString(pathObj),vf.createIRI("http://www.w3.org/2001/XMLSchema#Element"));// xml rendering?
            default:
                throw new SailException(String.format("Data Type %s is not supported.", cf.dataType));
        }
    }

    /**
     * perform execution
     * 
     * @param connection sail connection in which to perform the invocation
     * @return flag indicating whether execution has been attempted (or was already
     *         done)
     */
    public boolean execute(RemotingSailConnection connection) throws SailException {
        if (result == null) {
            startTime = System.currentTimeMillis();
            try {
                if (service.matcher.group("classType") != null) {
                    executeClass(connection);
                    return true;
                } else if (service.matcher.group("restType") != null) {
                    executeRest(connection);
                    return true;
                }
                throw new SailException("No class or rest binding found.");
            } finally {
                endTime = System.currentTimeMillis();
            }
        }
        return false;
    }

    /**
     * perform REST based executions
     * @param connection sail connection in which to perform the invocation
     */
    public void executeRest(RemotingSailConnection connection) throws SailException {
        try (final CloseableHttpClient httpclient = HttpClients.createDefault()) {
            String url = service.matcher.group("restType") + "://" + service.matcher.group("url");
            if (logger.isTraceEnabled()) {
                logger.trace(String.format("About to invoke REST call to %s ", url));
            }
            CloseableHttpResponse response = null;
            switch (service.method) {
                case "GET":
                    boolean isFirstArg = true;
                    for (Map.Entry<String, ArgumentConfig> argument : service.arguments.entrySet()) {
                        if (logger.isTraceEnabled()) {
                            logger.trace(String.format("About to process argument %s %s", argument.getKey(),argument.getValue()));
                        }                            
                        Value binding = inputs.get(connection.remotingSail.config.vf.createIRI(argument.getKey()));
                        Object render = convertToObject(binding, String.class);
                        if (isFirstArg) {
                            isFirstArg = false;
                            url = url + "?" + argument.getValue().argumentName;
                        } else {
                            url = url + "&" + argument.getValue().argumentName;
                        }
                        url = url + "=" + render;
                    }
                    if (logger.isTraceEnabled()) {
                        logger.trace(String.format("Completed REST call target with parameters to %s ", url));
                    }
                    final HttpGet httpget = new HttpGet(url);
                    if (logger.isDebugEnabled()) {
                        logger.debug(String.format("Performing %s ", httpget));
                    }
                    response = httpclient.execute(httpget);
                    break;

                case "POST-JSON":
                case "POST-JSON-MF":
                    ObjectMapper objectMapper = new ObjectMapper();

                    ObjectNode body=objectMapper.createObjectNode();
                    ObjectNode message=body;
                    ObjectNode input=body;

                    if(service.inputProperty!=null) {
                        String[] path= service.inputProperty.split("\\.");
                        for(int count=0;count<path.length;count++) {
                            message=input;
                            input=objectMapper.createObjectNode();
                            message.set(path[count],input);
                        }
                        if(service.batch>1) {
                            ArrayNode array=objectMapper.createArrayNode();
                            message.set(path[path.length-1],array);
                            array.add(input);
                        }
                    } else {
                        if (service.batch > 1) {
                            throw new SailException(String.format("Cannot use batch mode without inputProperty."));
                        }
                    }

                    if(service.invocationIdProperty!=null) {
                        if(!message.isObject()) {
                            throw new SailException(String.format("Cannot use invocationIdProperty in batch mode without inputProperty."));
                        } else {
                            ((ObjectNode) message).set(service.invocationIdProperty,objectMapper.getNodeFactory().textNode(key.stringValue()));
                        }
                    }

                    for (Map.Entry<String, ArgumentConfig> argument : service.arguments.entrySet()) {
                        if (logger.isTraceEnabled()) {
                            logger.trace(String.format("About to process argument %s %s", argument.getKey(),argument.getValue()));
                        }                            
                        Value binding = inputs.get(connection.remotingSail.config.vf.createIRI(argument.getKey()));
                        JsonNode render = convertToObject(binding, JsonNode.class);
                        String pathName=argument.getValue().argumentName;
                        String[] argPath = pathName.split("\\.");
                        ObjectNode traverse = input;
                        int depth = 0;
                        for (String argField : argPath) {
                            if (depth != argPath.length - 1) {
                                if (traverse.has(argField)) {
                                    JsonNode next = traverse.get(argField);
                                    if (!(next instanceof ObjectNode)) {
                                        throw new SailException(String
                                                .format("Field %s was occupied by a non-object %s", argField, next));
                                    } else {
                                        traverse = (ObjectNode) next;
                                    }
                                } else {
                                    ObjectNode next = objectMapper.createObjectNode();
                                    traverse.set(argField, next);
                                    traverse = next;
                                }
                            } else {
                                traverse.set(argField, render);
                            }
                            depth++;
                        }
                    }
                    if (logger.isTraceEnabled()) {
                        logger.trace(String.format("Derived body %s", body));
                    }
                    //objectMapper.enable(SerializationFeature.INDENT_OUTPUT);
                    final HttpPost httppost = new HttpPost(url);
                    if (service.method.equals("POST-JSON")) {
                        httppost.setEntity(new StringEntity(objectMapper.writeValueAsString(body)));
                    } else {
                        MultipartEntityBuilder mpeb = MultipartEntityBuilder.create();
                        mpeb.setBoundary("XXX");
                        Iterator<String> fields = body.fieldNames();
                        while (fields.hasNext()) {
                            String field = fields.next();
                            JsonNode node = body.get(field);
                            String content = objectMapper.writeValueAsString(node);
                            mpeb.addBinaryBody(field, content.getBytes(), ContentType.APPLICATION_JSON,field+".json");
                        }
                        httppost.setEntity(mpeb.build());
                    }
                    if (logger.isDebugEnabled()) {
                        logger.debug(String.format("Performing %s ", httppost));
                    }
                    response = httpclient.execute(httppost);
                    break;

                default:
                    throw new SailException(String.format("Cannot invoke method %s", service.method));
            }

            success = response.getStatusLine().getStatusCode();
            if (success >= 200 && success < 300) {
                final HttpEntity entity = response.getEntity();
                boolean isJson = false;
                boolean isXml = false;
                for (Header contentType : response.getHeaders("Content-Type")) {
                    if (contentType.getValue().contains("json")) {
                        isJson = true;
                    } else if (contentType.getValue().contains("xml")) {
                        isXml = true;
                    }
                }
                try {
                    if (isXml) {
                        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
                        DocumentBuilder builder = factory.newDocumentBuilder();
                        ByteArrayInputStream input = new ByteArrayInputStream(EntityUtils.toByteArray(entity));
                        result = builder.parse(input).getDocumentElement();
                    } else if (isJson) {
                        ObjectMapper mapper = new ObjectMapper();
                        ByteArrayInputStream input = new ByteArrayInputStream(EntityUtils.toByteArray(entity));
                        result = mapper.readTree(input);
                    } else {
                        result = EntityUtils.toString(entity);
                    }
                } catch (final org.apache.http.ParseException ex) {
                    throw new SailException(ex);
                } catch (ParserConfigurationException e) {
                    throw new SailException(e);
                } catch (SAXException e) {
                    throw new SailException(e);
                }
            }
        } catch (IOException ioe) {
            success = 500;
            result = ioe;
        }
    }

    /**
     * perform class-based reflection execution
     * 
     * @param connection sail connection in which to perform the invocation
     */
    public void executeClass(RemotingSailConnection connection) throws SailException {
        Class targetClass = null;
        try {
            targetClass = getClass().getClassLoader().loadClass(service.matcher.group("class"));
        } catch (ClassNotFoundException e) {
            throw new SailException(e);
        }
        if (logger.isTraceEnabled()) {
            logger.trace(String.format("Found class %s ", targetClass));
        }
        Method targetMethod = null;
        Object[] targetParams = null;
        try {
            for (Method meth : targetClass.getMethods()) {
                if (meth.getName().equals(service.matcher.group("method"))) {
                    if (logger.isTraceEnabled()) {
                        logger.trace(String.format("Found method %s ", meth));
                    }
                    targetParams = new Object[meth.getParameterTypes().length];
                    int argIndex = 0;
                    for (Parameter param : meth.getParameters()) {
                        if (logger.isTraceEnabled()) {
                            logger.trace(String.format("Checking parameter %s", param));
                        }
                        ArgumentConfig config = null;
                        for (Map.Entry<String, ArgumentConfig> argument : service.arguments.entrySet()) {
                            if (logger.isTraceEnabled()) {
                                logger.trace(String.format("Agains argument %s %s", argument.getKey(),
                                        argument.getValue().argumentName));
                            }
                            if (argument.getValue().argumentName.equals(param.getName())) {
                                config = argument.getValue();
                                Value binding = inputs
                                        .get(connection.remotingSail.config.vf.createIRI(argument.getKey()));
                                targetParams[argIndex++] = convertToObject(binding, param.getType());
                                break;
                            }
                        }
                        if (logger.isTraceEnabled()) {
                            logger.trace(String.format("Parameter %s resulted to argument %s ", param, config));
                        }
                        if (config == null) {
                            targetParams = null;
                            break;
                        }
                    }
                    if (targetParams != null) {
                        targetMethod = meth;
                        break;
                    }
                }
            }
            if (targetMethod == null) {
                throw new SailException(
                        String.format("Target method %s with suitable arguments could not be found in class %s.",
                                service.matcher.group("method"), targetClass));
            }
        } finally {
        }
        Object targetInstance = null;
        try {
            targetInstance = targetClass.getConstructor().newInstance();
        } catch (NoSuchMethodException e) {
            throw new SailException(e);
        } catch (IllegalAccessException e) {
            throw new SailException(e);
        } catch (InstantiationException e) {
            throw new SailException(e);
        } catch (InvocationTargetException e) {
            throw new SailException(e.getCause());
        }
        try {
            result = targetMethod.invoke(targetInstance, targetParams);
        } catch (InvocationTargetException e) {
            result = e.getCause();
            success = 500;
        } catch (Exception e) {
            result = e;
            success = 500;
        }
    }

    public String[] getResults() {
        if(service.batch>1) {
            return new String[] { "0" };
        }
        return new String[] { null };
    }
}