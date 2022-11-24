//
// Application to provide REST APIs as SPARQL services
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.agents.remoting;

import org.eclipse.rdf4j.query.BindingSet;
import org.eclipse.rdf4j.query.MutableBindingSet;
import org.eclipse.rdf4j.query.algebra.*;
import org.eclipse.rdf4j.sail.SailException;
import org.eclipse.rdf4j.model.IRI;
import org.eclipse.rdf4j.query.impl.MapBindingSet;
import org.eclipse.rdf4j.model.Value;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

/**
 * The query processing is done while visiting 
 */
public class RemotingQueryModelVisitor implements QueryModelVisitor<SailException>, IBindingHost {

	/** the state */
	protected Map<Value,Invocation> invocations=new HashMap<Value,Invocation>();

    /** bindings and results */
    final protected Set<String> variables=new HashSet<>();
    final protected Collection<MutableBindingSet> bindings= new ArrayList<>();

    /** the logger */
    protected Logger logger = LoggerFactory.getLogger(getClass());
	/** the connection */
	protected RemotingSailConnection connection;

    /**
     * create a new visitor
     * @param connection
     */
	public RemotingQueryModelVisitor(RemotingSailConnection connection) {
		this.connection=connection;        
	}


    @Override
    public String toString() {
        return super.toString()+"/visitor";
    }

    @Override
	public void meet(QueryRoot node) throws SailException {
		logger.debug(String.format("Visiting a query root"));
		node.getArg().visit(this);
    }

    @Override
	public void meet(Add node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(And node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(ArbitraryLengthPath node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Avg node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    /**
     * convert a binding set to a mutable version
     * @param bs
     * @return mutable binding set
     */
    protected MutableBindingSet makeMutable(BindingSet bs) {
        if(bs instanceof MutableBindingSet) {
            return (MutableBindingSet) bs;
        } else {
            MutableBindingSet mbs=new MapBindingSet();
            for(String binding : bs.getBindingNames()) {
                mbs.addBinding(bs.getBinding(binding));
            }
            return mbs;
        }
    }

    @Override
	public void meet(BindingSetAssignment node) throws SailException {
        variables.addAll(node.getBindingNames());
        if(bindings.isEmpty()) {
            node.getBindingSets().forEach( binding -> {
                bindings.add(makeMutable(binding));
            });
        } else {
            bindings.forEach( binding -> {
                node.getBindingSets().forEach( joinBindings -> {
                   joinBindings.forEach( joinBinding -> {
                       binding.addBinding(joinBinding);
                   });
                });
            });
        }
    }

    @Override
	public void meet(BNodeGenerator node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Bound node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Clear node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Coalesce node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Compare node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(CompareAll node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(CompareAny node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(DescribeOperator node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Copy node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Count node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Create node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Datatype node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(DeleteData node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Difference node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Distinct node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(EmptySet node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Exists node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Extension node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(ExtensionElem node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Filter node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(FunctionCall node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Group node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(GroupConcat node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(GroupElem node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(If node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(In node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(InsertData node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Intersection node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(IRIFunction node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(IsBNode node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(IsLiteral node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
    public void meet(IsNumeric node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(IsResource node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(IsURI node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Join node) throws SailException {
        logger.debug(String.format("Visiting a join"));
        node.getLeftArg().visit(this);
        node.getRightArg().visit(this);
    }

    @Override
	public void meet(Label node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Lang node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(LangMatches node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(LeftJoin node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Like node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Load node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(LocalName node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(MathExpr node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Max node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Min node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Modify node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Move node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(MultiProjection node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Namespace node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Not node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Or node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Order node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(OrderElem node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Projection node) throws SailException {
		logger.debug(String.format("Visiting a projection"));
		node.getArg().visit(this);
        for(Invocation invocation : invocations.values()) {
            invocation.execute(connection,this);
        }
		node.getProjectionElemList().visit(this);
    }

    @Override
	public void meet(ProjectionElem node) throws SailException {
		logger.debug(String.format("Visiting a projection element"));
        bindings.forEach( binding -> {
            if(node.getTargetName()!= null && !node.getTargetName().equals(node.getSourceName())) {
                if (!binding.hasBinding(node.getTargetName())) {
                    if (!binding.hasBinding(node.getSourceName())) {
                        logger.warn(String.format("Could not bind source var %s to target var %s. Leaving unbound.", node.getSourceName(), node.getTargetName()));
                    }
                    binding.addBinding(node.getTargetName(), binding.getValue(node.getSourceName()));
                }
            }
        });
    }

    @Override
    public void meet(ProjectionElemList node) throws SailException {
		logger.debug(String.format("Visiting a projection list"));
        node.visitChildren(this);
    }

    @Override
	public void meet(Reduced node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Regex node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(SameTerm node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Sample node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Service node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(SingletonSet node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Slice node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(StatementPattern statement) throws SailException {
        Var predicate=statement.getPredicateVar();
        Var object = statement.getObjectVar();
        if(bindings.isEmpty()) {
            bindings.add(new MapBindingSet());
        }
        if(!predicate.hasValue() || !predicate.getValue().isIRI()) {
            throw new SailException(String.format("No support for non-IRI predicate binding %s",predicate));
        } else if("http://www.w3.org/1999/02/22-rdf-syntax-ns#type".equals(predicate.getValue().stringValue())) {
            if(!object.hasValue() || !object.getValue().isIRI()) {
                throw new SailException(String.format("No support for non-IRI invocation type binding %s",object));
            }
            IRI objectIRI = (IRI) object.getValue();
            // TODO lookup configuration 
            Var subject = statement.getSubjectVar();
            if(!subject.hasValue() ) {
                IRI invocationIri=connection.remotingSail.getValueFactory().createIRI(objectIRI.getNamespace(),String.valueOf(invocations.size()));
                for(MutableBindingSet binding : bindings) {
                    binding.addBinding(subject.getName(),invocationIri);
                }
                subject=new Var(subject.getName(),invocationIri);
            } else {
                if(!subject.getValue().isIRI()) {
                    throw new SailException(String.format("No support for non-IRI invocation subject binding %s",subject));
                }
                if(!((IRI)subject.getValue()).getNamespace().equals(objectIRI.getNamespace())) {
                    throw new SailException(String.format("No support for non-IRI invocation subject binding %s",subject));
                }
            }
            InvocationConfig ic=connection.remotingSail.config.invocations.get(objectIRI.stringValue());
            if(ic==null) {
                throw new SailException(String.format("Function %s was not configured",objectIRI));
            }
            Invocation invocation = invocations.get(subject.getValue());
            if(invocation!=null) {
                if(!invocation.service.equals(ic)) {
                    throw new SailException(String.format("Could not rebind invocation %s with type %s to type %s",subject.getValue(),invocation.service,object.getValue()));
                }
            } else {
                invocation=new Invocation(connection);
                invocation.service=ic;
                invocation.key=(IRI) bindings.stream().findFirst().get().getBinding(subject.getName()).getValue();
                logger.debug(String.format("Registering a new invocation %s for service type %s",subject.getValue(),invocation.service));
                invocations.put(subject.getValue(),invocation);
            }
        } else {
            Var subject = statement.getSubjectVar();
            if(!subject.hasValue()) {
                if(!bindings.stream().findFirst().get().hasBinding(subject.getName())) {
                    throw new SailException(String.format("Subject variable %s not bound to invocation or result.",subject.getName()));
                } 
                subject=new Var(subject.getName(),bindings.stream().findFirst().get().getValue(subject.getName()));
            }
            if(!invocations.containsKey(subject.getValue())) {
                throw new SailException(String.format("Trying to bind argument predicate %s to non existant invocation %s. Maybe you need to switch statement order such that rdf:type precedes any other bindings.",predicate.getValue().stringValue(),subject));
            }
            Invocation invocation=invocations.get(subject.getValue());
            IRI argument=(IRI) predicate.getValue();
            if(invocation.service.result.outputs.containsKey(argument.stringValue())) {
                invocation.outputs.put(object,argument);
            } else if(invocation.service.arguments.containsKey(argument.stringValue())) {
                invocation.inputs.put(argument.stringValue(),object);
            } else {
                throw new SailException(String.format("Predicate %s is neither output nor input predicate for invocation %s",argument,subject));
            }
        }
    }

    @Override
	public void meet(Str node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Sum node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Union node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(ValueConstant node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

   @Override
	public void meet(ListMemberOperator node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(Var node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meet(ZeroLengthPath node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

	/**
	 * @implNote This temporary default method is only supplied as a stop-gap for backward compatibility. Concrete
	 *           implementations are expected to override.
	 * @since 3.2.0
	 */
    @Override
	public void meet(TripleRef node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

	/**
	 * @implNote This temporary default method is only supplied as a stop-gap for backward compatibility. Concrete
	 *           implementations are expected to override.
	 * @since 3.2.0
	 */
    @Override
	public void meet(ValueExprTripleRef node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
	public void meetOther(QueryModelNode node) throws SailException {
        throw new SailException(String.format("No support for %s",node));
    }

    @Override
    public Set<String> getVariables() {
        return variables;
    }

    @Override
    public Collection<MutableBindingSet> getBindings() {
        return bindings;
    }
}