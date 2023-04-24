//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.service;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.fasterxml.jackson.databind.annotation.JsonPOJOBuilder;
import org.eclipse.edc.connector.contract.spi.types.negotiation.ContractNegotiation.Type;

@JsonDeserialize(builder = ContractNegotiation.Builder.class)
public class ContractNegotiation {
    private String contractAgreementId; // is null until state == CONFIRMED
    private String counterPartyAddress;
    private String errorDetail;
    private String id;
    private String protocol = "ids-multipart";
    private String state;
    private Type type = Type.CONSUMER;

    private ContractNegotiation() {
    }

    public String getId() {
        return id;
    }

    public String getCounterPartyAddress() {
        return counterPartyAddress;
    }

    public String getProtocol() {
        return protocol;
    }

    public Type getType() {
        return type;
    }

    public String getState() {
        return state;
    }

    public String getErrorDetail() {
        return errorDetail;
    }

    public String getContractAgreementId() {
        return contractAgreementId;
    }

    @JsonPOJOBuilder(withPrefix = "")
    public static final class Builder {
        private final ContractNegotiation dto;

        private Builder() {
            dto = new ContractNegotiation();
        }

        @JsonCreator
        public static Builder newInstance() {
            return new Builder();
        }

        public Builder id(String id) {
            dto.id = id;
            return this;
        }

        public Builder counterPartyAddress(String counterPartyAddress) {
            dto.counterPartyAddress = counterPartyAddress;
            return this;
        }

        public Builder protocol(String protocol) {
            dto.protocol = protocol;
            return this;
        }

        public Builder state(String state) {
            dto.state = state;
            return this;
        }

        public Builder errorDetail(String errorDetail) {
            dto.errorDetail = errorDetail;
            return this;
        }

        public Builder contractAgreementId(String contractAgreementId) {
            dto.contractAgreementId = contractAgreementId;
            return this;
        }

        public Builder type(Type type) {
            dto.type = type;
            return this;
        }

        public ContractNegotiation build() {
            return dto;
        }
    }
}