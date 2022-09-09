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

@JsonDeserialize(builder = DataRequest.Builder.class)
public class DataRequest {
    private String assetId;
    private String contractId;
    private String connectorId;

    private DataRequest() {
    }

    public String getAssetId() {
        return assetId;
    }

    public String getContractId() {
        return contractId;
    }

    public String getConnectorId() {
        return connectorId;
    }

    @JsonPOJOBuilder(withPrefix = "")
    public static final class Builder {

        private final DataRequest dataRequestDto;

        private Builder() {
            dataRequestDto = new DataRequest();
        }

        @JsonCreator
        public static Builder newInstance() {
            return new Builder();
        }

        public Builder assetId(String assetId) {
            dataRequestDto.assetId = assetId;
            return this;
        }

        public Builder contractId(String contractId) {
            dataRequestDto.contractId = contractId;
            return this;
        }

        public Builder connectorId(String connectorId) {
            dataRequestDto.connectorId = connectorId;
            return this;
        }

        public DataRequest build() {
            return dataRequestDto;
        }
    }
}