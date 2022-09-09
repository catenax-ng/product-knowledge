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

@JsonDeserialize(builder = TransferProcess.Builder.class)
public class TransferProcess {
    private String id;
    private String type;
    private String state;
    private String errorDetail;
    private DataRequest dataRequest;
    private DataAddressInformation dataDestination;

    private TransferProcess() {
    }

    public String getId() {
        return id;
    }

    public String getType() {
        return type;
    }

    public String getState() {
        return state;
    }

    public String getErrorDetail() {
        return errorDetail;
    }

    public DataRequest getDataRequest() {
        return dataRequest;
    }

    public DataAddressInformation getDataDestination() {
        return dataDestination;
    }

    @JsonPOJOBuilder(withPrefix = "")
    public static final class Builder {
        private final TransferProcess transferProcessDto;

        private Builder() {
            transferProcessDto = new TransferProcess();
        }

        @JsonCreator
        public static Builder newInstance() {
            return new Builder();
        }

        public Builder id(String id) {
            transferProcessDto.id = id;
            return this;
        }

        public Builder type(String type) {
            transferProcessDto.type = type;
            return this;
        }

        public Builder state(String state) {
            transferProcessDto.state = state;
            return this;
        }

        public Builder errorDetail(String errorDetail) {
            transferProcessDto.errorDetail = errorDetail;
            return this;
        }

        public Builder dataRequest(DataRequest dataRequest) {
            transferProcessDto.dataRequest = dataRequest;
            return this;
        }

        public Builder dataDestination(DataAddressInformation dataDestination) {
            transferProcessDto.dataDestination = dataDestination;
            return this;
        }

        public TransferProcess build() {
            return transferProcessDto;
        }
    }
}