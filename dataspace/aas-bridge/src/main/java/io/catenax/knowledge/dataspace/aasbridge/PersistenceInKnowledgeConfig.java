package io.catenax.knowledge.dataspace.aasbridge;

import de.fraunhofer.iosb.ilt.faaast.service.persistence.PersistenceConfig;
import org.eclipse.digitaltwin.aas4j.mapping.model.MappingSpecification;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.net.URI;
import java.util.Map;

public class PersistenceInKnowledgeConfig extends PersistenceConfig<PersistenceInKnowledge> {

    private static final Logger LOGGER = LoggerFactory.getLogger(PersistenceInKnowledgeConfig.class);
    private Map<File, MappingSpecification> mappings;
    private URI providerSparqlEndpoint;
    private URI providerAgentPlane;
    private String credentials;
    private int threadPoolSize;
    private int timeoutSeconds;


    public Map<File, MappingSpecification> getMappings() {
        return mappings;
    }

    public void setMappings(Map<File, MappingSpecification> mappings) {
        this.mappings = mappings;
    }


    public static Builder builder() {
        return new Builder();
    }

    public URI getProviderSparqlEndpoint() {
        return providerSparqlEndpoint;
    }

    public String getCredentials() {
        return credentials;
    }

    public int getThreadPoolSize() {
        return threadPoolSize;
    }

    public int getTimeoutSeconds() {
        return timeoutSeconds;
    }

    public void setProviderSparqlEndpoint(URI providerSparqlEndpoint) {
        this.providerSparqlEndpoint = providerSparqlEndpoint;
    }

    public void setCredentials(String credentials) {
        this.credentials = credentials;
    }

    public void setThreadPoolSize(int threadPoolSize) {
        this.threadPoolSize = threadPoolSize;
    }

    public void setTimeoutSeconds(int timeoutSeconds) {
        this.timeoutSeconds = timeoutSeconds;
    }

    public URI getProviderAgentPlane() {
        return providerAgentPlane;
    }

    public void setProviderAgentPlane(URI providerAgentPlane) {
        this.providerAgentPlane = providerAgentPlane;
    }

    private abstract static class AbstractBuilder<T extends PersistenceInKnowledgeConfig, B extends AbstractBuilder<T, B>> extends PersistenceConfig.AbstractBuilder<PersistenceInKnowledge, T, B> {
        public B mappings(Map<File, MappingSpecification> value) {
            getBuildingInstance().setMappings(value);
            return getSelf();
        }

        public B providerSparqlEndpoint(URI value) {
            getBuildingInstance().setProviderSparqlEndpoint(value);
            return getSelf();
        }

        public B providerAgentPlane(URI value) {
            getBuildingInstance().setProviderAgentPlane(value);
            return getSelf();
        }


        public B credentials(String value) {
            getBuildingInstance().setCredentials(value);
            return getSelf();
        }

        public B threadPoolSize(int value) {
            getBuildingInstance().setThreadPoolSize(value);
            return getSelf();
        }

        public B timeoutSeconds(int value) {
            getBuildingInstance().setTimeoutSeconds(value);
            return getSelf();
        }
    }

    public static class Builder extends AbstractBuilder<PersistenceInKnowledgeConfig, Builder> {

        @Override
        protected Builder getSelf() {
            return this;
        }


        @Override
        protected PersistenceInKnowledgeConfig newBuildingInstance() {
            return new PersistenceInKnowledgeConfig();
        }
    }

}
