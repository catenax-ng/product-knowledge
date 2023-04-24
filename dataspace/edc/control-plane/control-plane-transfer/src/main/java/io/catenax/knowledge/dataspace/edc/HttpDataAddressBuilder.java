//
// EDC Control Plane Agent Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package io.catenax.knowledge.dataspace.edc;

import org.eclipse.edc.spi.types.domain.DataAddress;

/**
 * A helper to build HttpDataAddress with the right type‚^
 */
public class HttpDataAddressBuilder {

    /** its a hidden thingy in the builder */
    protected static java.lang.reflect.Field addressField=null;
    // open it up
    static {
        try {
            addressField=DataAddress.Builder.class.getDeclaredField("address");
            addressField.trySetAccessible();
        } catch(SecurityException | NoSuchFieldException ignored) {
        }
    }

    /**
     * build the dataaddress with the correct type
     * @param builder the builder to extract the addess from
     * @return built dataaddress without additional logic
     */
    public static DataAddress build(@SuppressWarnings("rawtypes") DataAddress.Builder builder) {
        if(addressField!=null) {
            try {
                return (DataAddress) addressField.get(builder);
            } catch(IllegalAccessException ignored) {
            } 
        } 
        return builder.build();
    }
}
