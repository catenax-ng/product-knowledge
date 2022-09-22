//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.service;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import org.eclipse.dataspaceconnector.policy.model.Policy;
import org.eclipse.dataspaceconnector.spi.types.domain.contract.negotiation.ContractNegotiation.Type;

@JsonDeserialize(builder = ContractAgreement.Builder.class)
public class ContractAgreement {
    private String id;
    private String providerAgentId;
    private String consumerAgentId;
    private long contractSigningDate;
    private long contractStartDate;
    private long contractEndDate;
    private String assetId;
    private Policy policy;

    @JsonIgnore
    public boolean isDatesValid() {

        return contractStartDate < contractEndDate &&
                contractSigningDate < contractEndDate;
    }

    public String getId() {
        return id;
    }

    public String getProviderAgentId() {
        return providerAgentId;
    }

    public String getConsumerAgentId() {
        return consumerAgentId;
    }

    public long getContractSigningDate() {
        return contractSigningDate;
    }

    public long getContractStartDate() {
        return contractStartDate;
    }

    public long getContractEndDate() {
        return contractEndDate;
    }

    public String getAssetId() {
        return assetId;
    }

    public Policy getPolicy() {
        return policy;
    }

    @JsonPOJOBuilder(withPrefix = "")
    public static final class Builder {
        private final ContractAgreement agreement;

        private Builder() {
            agreement = new ContractAgreement();
        }

        public static Builder newInstance() {
            return new Builder();
        }

        public Builder id(String id) {
            agreement.id = id;
            return this;
        }

        public Builder providerAgentId(String providerAgentId) {
            agreement.providerAgentId = providerAgentId;
            return this;
        }

        public Builder consumerAgentId(String consumerAgentId) {
            agreement.consumerAgentId = consumerAgentId;
            return this;
        }

        public Builder contractSigningDate(long contractSigningDate) {
            agreement.contractSigningDate = contractSigningDate;
            return this;
        }

        public Builder contractStartDate(long contractStartDate) {
            agreement.contractStartDate = contractStartDate;
            return this;
        }

        public Builder contractEndDate(long contractEndDate) {
            agreement.contractEndDate = contractEndDate;
            return this;
        }

        public Builder assetId(String assetId) {
            agreement.assetId = assetId;
            return this;
        }

        public Builder policy(Policy policy) {
            agreement.policy = policy;
            return this;
        }

        public ContractAgreement build() {
            return agreement;
        }
    }
}