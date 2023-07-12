package io.catenax.knowledge.dataspace.aasbridge;

import de.fraunhofer.iosb.ilt.faaast.service.persistence.PersistenceConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.URI;
import java.util.List;

public class PersistenceInKnowledgeConfig extends PersistenceConfig<PersistenceInKnowledge> {

    private static final Logger LOGGER = LoggerFactory.getLogger(PersistenceInKnowledgeConfig.class);
    private List<MappingConfiguration> mappings; // query to mappingspecification
    private URI providerSparqlEndpoint;
    private String credentials;
    private int threadPoolSize;
    private int timeoutSeconds;


    public List<MappingConfiguration> getMappings() {
        return mappings;
    }

    public void setMappings(List<MappingConfiguration> mappings) {
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

    private abstract static class AbstractBuilder<T extends PersistenceInKnowledgeConfig, B extends AbstractBuilder<T, B>> extends PersistenceConfig.AbstractBuilder<PersistenceInKnowledge, T, B> {
        public B mappings(List<MappingConfiguration> value) {
            getBuildingInstance().setMappings(value);
            return getSelf();
        }

        public B providerSparqlEndpoint(URI value) {
            getBuildingInstance().setProviderSparqlEndpoint(value);
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
