//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.sparql;

import org.apache.jena.atlas.io.IndentedWriter;
import org.apache.jena.graph.Node;
import org.apache.jena.query.Query;
import org.apache.jena.query.QueryVisitor;
import org.apache.jena.query.SortCondition;
import org.apache.jena.sparql.core.Prologue;
import org.apache.jena.sparql.core.Var;
import org.apache.jena.sparql.core.VarExprList;
import org.apache.jena.sparql.engine.binding.Binding;
import org.apache.jena.sparql.expr.Expr;
import org.apache.jena.sparql.serializer.*;
import org.apache.jena.sparql.syntax.Element;
import org.apache.jena.sparql.syntax.Template;
import org.apache.jena.sparql.util.FmtUtils;

import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

/**
 * we need to reimplement QuerySerializer just because of hidden constructors
 * All we want to reach is to put a different formatter element into
 * the call.
 * TODO try to remove this by another solution (reflection?)
 */
public class SparqlQuerySerializer implements QueryVisitor {
    protected FormatterTemplate fmtTemplate;
    protected StratifiedFormatterElement fmtElement;
    protected FmtExprSPARQL fmtExpr;
    protected IndentedWriter out;
    protected Prologue prologue;

    public SparqlQuerySerializer(OutputStream _out, StratifiedFormatterElement formatterElement, FmtExprSPARQL formatterExpr, FormatterTemplate formatterTemplate) {
        this(new IndentedWriter(_out), formatterElement, formatterExpr, formatterTemplate);
    }

    public SparqlQuerySerializer(IndentedWriter iwriter, StratifiedFormatterElement formatterElement, FmtExprSPARQL formatterExpr, FormatterTemplate formatterTemplate) {
        this.prologue = null;
        this.out = iwriter;
        this.fmtTemplate = formatterTemplate;
        this.fmtElement = formatterElement;
        this.fmtExpr = formatterExpr;
    }

    @Override
    public void startVisit(Query query) {
    }

    @Override
    public void visitResultForm(Query query) {
    }

    @Override
    public void visitPrologue(Prologue prologue) {
        this.prologue = prologue;
        int row1 = this.out.getRow();
        PrologueSerializer.output(this.out, prologue);
        int row2 = this.out.getRow();
        if (row1 != row2) {
            this.out.newline();
        }
    }

    @Override
    public void visitSelectResultForm(Query query) {
        this.out.print("SELECT ");
        if (query.isDistinct()) {
            this.out.print("DISTINCT ");
        }

        if (query.isReduced()) {
            this.out.print("REDUCED ");
        }

        this.out.print(" ");
        if (query.isQueryResultStar()) {
            this.out.print("*");
        } else {
            this.appendNamedExprList(this.out, query.getProject());
        }

        this.out.newline();
    }

    @Override
    public void visitConstructResultForm(Query query) {
        this.out.print("CONSTRUCT ");
        this.out.incIndent(2);
        this.out.newline();
        Template t = query.getConstructTemplate();
        this.fmtTemplate.format(t);
        this.out.decIndent(2);
    }

    @Override
    public void visitDescribeResultForm(Query query) {
        this.out.print("DESCRIBE ");
        if (query.isQueryResultStar()) {
            this.out.print("*");
        } else {
            this.appendVarList(this.out, query.getResultVars());
            if (query.getResultVars().size() > 0 && query.getResultURIs().size() > 0) {
                this.out.print(" ");
            }

            appendURIList(query, this.out, query.getResultURIs());
        }

        this.out.newline();
    }

    @Override
    public void visitAskResultForm(Query query) {
        this.out.print("ASK");
        this.out.newline();
    }

    @Override
    public void visitJsonResultForm(Query query) {
        this.out.println("JSON {");
        this.out.incIndent(2);
        this.out.incIndent(2);
        boolean first = true;

        for (Map.Entry<String, Node> entry : query.getJsonMapping().entrySet()) {
            String field = entry.getKey();
            Node value = entry.getValue();
            if (!first) {
                this.out.println(" ,");
            }

            first = false;
            this.out.print('"');
            this.out.print(field);
            this.out.print('"');
            this.out.print(" : ");
            this.out.pad(15);
            this.out.print(FmtUtils.stringForNode(value, this.prologue));
        }

        this.out.decIndent(2);
        this.out.decIndent(2);
        this.out.print(" }");
        this.out.newline();
    }

    @Override
    public void visitDatasetDecl(Query query) {
        Iterator<String> var2;
        String uri;
        if (query.getGraphURIs() != null && query.getGraphURIs().size() != 0) {
            var2 = query.getGraphURIs().iterator();

            while(var2.hasNext()) {
                uri = var2.next();
                this.out.print("FROM ");
                this.out.print(FmtUtils.stringForURI(uri, query));
                this.out.newline();
            }
        }

        if (query.getNamedGraphURIs() != null && query.getNamedGraphURIs().size() != 0) {
            var2 = query.getNamedGraphURIs().iterator();

            while(var2.hasNext()) {
                uri = var2.next();
                this.out.print("FROM NAMED ");
                this.out.print(FmtUtils.stringForURI(uri, query));
                this.out.newline();
            }
        }

    }

    @Override
    public void visitQueryPattern(Query query) {
        if (query.getQueryPattern() != null) {
            this.out.print("WHERE");
            this.out.incIndent(2);
            this.out.newline();
            Element el = query.getQueryPattern();
            this.fmtElement.visitAsGroup(el);
            this.out.decIndent(2);
            this.out.newline();
        }

    }

    @Override
    public void visitGroupBy(Query query) {
        if (query.hasGroupBy() && !query.getGroupBy().isEmpty()) {
            this.out.print("GROUP BY ");
            this.appendNamedExprList(this.out, query.getGroupBy());
            this.out.println();
        }

    }

    @Override
    public void visitHaving(Query query) {
        if (query.hasHaving()) {
            this.out.print("HAVING");

            for (Expr expr : query.getHavingExprs()) {
                this.out.print(" ");
                this.fmtExpr.format(expr);
            }

            this.out.println();
        }

    }

    @Override
    public void visitOrderBy(Query query) {
        if (query.hasOrderBy()) {
            this.out.print("ORDER BY ");
            boolean first = true;

            for(Iterator<SortCondition> var3 = query.getOrderBy().iterator(); var3.hasNext(); first = false) {
                SortCondition sc = var3.next();
                if (!first) {
                    this.out.print(" ");
                }

                sc.format(this.fmtExpr, this.out);
            }

            this.out.println();
        }

    }

    @Override
    public void visitLimit(Query query) {
        if (query.hasLimit()) {
            this.out.print("LIMIT   " + query.getLimit());
            this.out.newline();
        }

    }

    @Override
    public void visitOffset(Query query) {
        if (query.hasOffset()) {
            this.out.print("OFFSET  " + query.getOffset());
            this.out.newline();
        }

    }

    @Override
    public void visitValues(Query query) {
        if (query.hasValues()) {
            outputDataBlock(this.out, query.getValuesVariables(), query.getValuesData(), this.fmtElement.sc);
            this.out.newline();
        }

    }

    public static void outputDataBlock(IndentedWriter out, List<Var> variables, List<Binding> values, SerializationContext cxt) {
        out.print("VALUES ");
        Binding valueRow;
        if (variables.size() == 1) {
            out.print("?");
            out.print(variables.get(0).getVarName());
            out.print(" {");
            out.incIndent();

            for (Binding value : values) {
                valueRow = value;
                outputValuesOneRow(out, variables, valueRow, cxt);
            }

            out.decIndent();
            out.print(" }");
        } else {
            out.print("(");

            for (Var v : variables) {
                out.print(" ");
                out.print(v.toString());
            }

            out.print(" )");
            out.print(" {");
            out.incIndent();

            for (Binding value : values) {
                valueRow = value;
                out.println();
                out.print("(");
                outputValuesOneRow(out, variables, valueRow, cxt);
                out.print(" )");
            }

            out.decIndent();
            out.ensureStartOfLine();
            out.print("}");
        }
    }

    private static void outputValuesOneRow(IndentedWriter out, List<Var> variables, Binding row, SerializationContext cxt) {

        for (Var var : variables) {
            out.print(" ");
            Node value = row.get(var);
            if (value == null) {
                out.print("UNDEF");
            } else {
                out.print(FmtUtils.stringForNode(value, cxt));
            }
        }

    }

    @Override
    public void finishVisit(Query query) {
        this.out.flush();
    }

    void appendVarList(IndentedWriter sb, List<String> vars) {
        boolean first = true;

        for(Iterator<String> var5 = vars.iterator(); var5.hasNext(); first = false) {
            String varName = var5.next();
            Var var = Var.alloc(varName);
            if (!first) {
                sb.print(" ");
            }

            sb.print(var.toString());
        }

    }

    void appendNamedExprList(IndentedWriter sb, VarExprList namedExprs) {
        boolean first = true;

        for(Iterator<Var> var5 = namedExprs.getVars().iterator(); var5.hasNext(); first = false) {
            Var var = var5.next();
            Expr expr = namedExprs.getExpr(var);
            if (!first) {
                sb.print(" ");
            }

            if (expr != null) {
                boolean needParens = true;
                if (expr.isFunction()) {
                    needParens = false;
                } else if (expr.isVariable()) {
                    needParens = false;
                }

                if (!Var.isAllocVar(var)) {
                    needParens = true;
                }

                if (needParens) {
                    this.out.print("(");
                }

                this.fmtExpr.format(expr);
                if (!Var.isAllocVar(var)) {
                    sb.print(" AS ");
                    sb.print(var.toString());
                }

                if (needParens) {
                    this.out.print(")");
                }
            } else {
                sb.print(var.toString());
            }
        }

    }

    static void appendURIList(Query query, IndentedWriter sb, List<Node> vars) {
        SerializationContext cxt = new SerializationContext(query);
        boolean first = true;

        for(Iterator<Node> var5 = vars.iterator(); var5.hasNext(); first = false) {
            Node node = var5.next();
            if (!first) {
                sb.print(" ");
            }

            sb.print(FmtUtils.stringForNode(node, cxt));
        }

    }
}
