//
// EDC Data Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc.service;

public class ContractNegotiationRequest {

    private String connectorAddress;
    private String protocol = "ids-multipart";
    private String connectorId;
    private ContractOfferDescription offer;

    private ContractNegotiationRequest() {

    }

    public String getConnectorAddress() {
        return connectorAddress;
    }

    public String getProtocol() {
        return protocol;
    }

    public String getConnectorId() {
        return connectorId;
    }

    public ContractOfferDescription getOffer() {
        return offer;
    }


    public static final class Builder {
        private final ContractNegotiationRequest dto;

        private Builder() {
            dto = new ContractNegotiationRequest();
        }

        public static Builder newInstance() {
            return new Builder();
        }

        public Builder connectorAddress(String connectorAddress) {
            dto.connectorAddress = connectorAddress;
            return this;
        }

        public Builder protocol(String protocol) {
            dto.protocol = protocol;
            return this;
        }

        public Builder connectorId(String connectorId) {
            dto.connectorId = connectorId;
            return this;
        }

        public Builder offerId(ContractOfferDescription offerId) {
            dto.offer = offerId;
            return this;
        }

        public ContractNegotiationRequest build() {
            return dto;
        }
    }
}
