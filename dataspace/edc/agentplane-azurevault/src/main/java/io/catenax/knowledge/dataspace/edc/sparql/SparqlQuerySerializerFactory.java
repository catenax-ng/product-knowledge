//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import org.apache.jena.atlas.io.IndentedWriter;
import org.apache.jena.query.QueryVisitor;
import org.apache.jena.query.Syntax;
import org.apache.jena.sparql.core.Prologue;
import org.apache.jena.sparql.serializer.*;
import org.apache.jena.sparql.util.NodeToLabelMapBNode;

/**
 * A serializer factory for sparql queries which
 * stratifies the resulting groups (joins) because not
 * all SparQL endpoints (such as ONTOP) can deal with the
 * level of nesting that fuseki syntax graphs represent with
 * their max-2 child operators.
 */
public class SparqlQuerySerializerFactory implements QuerySerializerFactory {
    @Override
    public QueryVisitor create(Syntax syntax, Prologue prologue, IndentedWriter writer) {
        SerializationContext cxt1 = new SerializationContext(prologue, new NodeToLabelMapBNode("b", false));
        SerializationContext cxt2 = new SerializationContext(prologue, new NodeToLabelMapBNode("c", false));
        return new SparqlQuerySerializer(writer, new StratifiedFormatterElement(writer, cxt1), new FmtExprSPARQL(writer, cxt1), new FmtTemplate(writer, cxt2));
    }

    @Override
    public QueryVisitor create(Syntax syntax, SerializationContext context, IndentedWriter writer) {
        return new SparqlQuerySerializer(writer, new StratifiedFormatterElement(writer, context), new FmtExprSPARQL(writer, context), new FmtTemplate(writer, context));
    }

    @Override
    public boolean accept(Syntax syntax) {
        return Syntax.syntaxARQ.equals(syntax) || Syntax.syntaxSPARQL_10.equals(syntax) || Syntax.syntaxSPARQL_11.equals(syntax);
    }
}
