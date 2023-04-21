//
// EDC Data Plane Agent Extension 
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.http;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import io.catenax.knowledge.dataspace.edc.TupleSet;
import org.apache.http.HttpStatus;
import org.slf4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.jena.fuseki.system.ActionCategory;
import org.apache.jena.fuseki.servlets.HttpAction;

import java.net.URLDecoder;
import java.util.Iterator;
import java.util.Stack;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.nio.charset.StandardCharsets.UTF_8;


/**
 * HttpAction which may either contain
 * a query or a predefined skill. In each case
 * the parameterization/input binding can be done either by
 * url parameters, by a binding set body or both.
 */
public class AgentHttpAction extends HttpAction {
    final String skill;
    final String graphs;
    final TupleSet tupleSet=new TupleSet();

    /**
     * regexes to deal with url parameters
     */
    public static String URL_PARAM_REGEX = "(?<key>[^=&]+)=(?<value>[^&]+)";
    public static Pattern URL_PARAM_PATTERN=Pattern.compile(URL_PARAM_REGEX);
    public static String RESULTSET_CONTENT_TYPE="application/sparql-results+json";

    /**
     * creates a new http action
     * @param id call id
     * @param logger the used logging output
     * @param request servlet input
     * @param response servlet output
     * @param skill option skill reference
     */
    public AgentHttpAction(long id, Logger logger, HttpServletRequest request, HttpServletResponse response, String skill, String graphs) {
        super(id, logger, ActionCategory.ACTION, request, response);
        this.skill=skill;
        this.graphs=graphs;
        parseArgs(request,response);
        parseBody(request,response);
    }

    protected void parseArgs(HttpServletRequest request, HttpServletResponse response) {
        String params = "";
        String uriParams = request.getQueryString();
        if (uriParams != null) {
            params = URLDecoder.decode(uriParams, UTF_8);
        }
        Matcher paramMatcher = URL_PARAM_PATTERN.matcher(params);
        Stack<TupleSet> ts = new Stack<>();
        ts.push(tupleSet);
        while (paramMatcher.find()) {
            String key = paramMatcher.group("key");
            String value = paramMatcher.group("value");
            while (key.startsWith("(")) {
                key = key.substring(1);
                ts.push(new TupleSet());
            }
            if (key.length() <= 0) {
                response.setStatus(HttpStatus.SC_BAD_REQUEST);
                return;
            }
            String realValue = value.replace(")", "");
            if (value.length() <= 0) {
                response.setStatus(HttpStatus.SC_BAD_REQUEST);
                return;
            }
            try {
                if (!"asset".equals(key) && !"query".equals(key)) {
                    ts.peek().add(key, realValue);
                }
            } catch (Exception e) {
                response.setStatus(HttpStatus.SC_BAD_REQUEST);
                return;
            }
            while (value.endsWith(")")) {
                TupleSet set1 = ts.pop();
                ts.peek().merge(set1);
                value = value.substring(0, value.length() - 1);
            }
        }
    }

    protected void parseBody(HttpServletRequest request, HttpServletResponse response) {
        if(RESULTSET_CONTENT_TYPE.equals(request.getContentType())) {
            ObjectMapper om= new ObjectMapper();
            try {
                JsonNode bindingSet=om.readTree(request.getInputStream());
                ArrayNode bindings=((ArrayNode) bindingSet.get("results").get("bindings"));
                for(int count=0;count<bindings.size();count++) {
                    TupleSet ts=new TupleSet();
                    JsonNode binding=bindings.get(count);
                    Iterator<String> vars = binding.fieldNames();
                    while(vars.hasNext()) {
                        String var = vars.next();
                        JsonNode value = binding.get(var).get("value");
                        ts.add(var,value.textValue());
                    }
                    tupleSet.merge(ts);
                }
            } catch(Exception e) {
                response.setStatus(HttpStatus.SC_BAD_REQUEST);
            }
        }
    }

    /**
     * @return optional skill
     */
    public String getSkill() {
        return skill;
    }

    /**
     * @return optional skill
     */
    public String getGraphs() {
        return graphs;
    }

    /**
     * @return the actual input bindings
     */
    public TupleSet getInputBindings() {
        return tupleSet;
    }
}
