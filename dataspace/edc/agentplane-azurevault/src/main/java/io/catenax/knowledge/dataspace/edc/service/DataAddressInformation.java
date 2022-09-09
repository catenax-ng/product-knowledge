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

import java.util.Map;

@JsonDeserialize(builder = DataAddressInformation.Builder.class)
public class DataAddressInformation {

    private Map<String, String> properties;

    private DataAddressInformation() {
    }

    public Map<String, String> getProperties() {
        return properties;
    }

    @JsonPOJOBuilder(withPrefix = "")
    public static final class Builder {

        private final DataAddressInformation dataAddressDto;

        private Builder() {
            dataAddressDto = new DataAddressInformation();
        }

        @JsonCreator
        public static Builder newInstance() {
            return new Builder();
        }

        public Builder properties(Map<String, String> properties) {
            dataAddressDto.properties = properties;
            return this;
        }

        public DataAddressInformation build() {
            return dataAddressDto;
        }

    }
}
