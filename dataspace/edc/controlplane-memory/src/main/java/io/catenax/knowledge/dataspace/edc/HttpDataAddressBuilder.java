package io.catenax.knowledge.dataspace.edc;

import org.eclipse.dataspaceconnector.spi.types.domain.DataAddress;

/**
 * A helper to build HttpDataAddress with the right type‚^
 */
public class HttpDataAddressBuilder {

    /** its a hidden thingy in the builder */
    protected static java.lang.reflect.Field addressField=null;
 
    /** open it up */
    static {
        try {
            addressField=DataAddress.Builder.class.getDeclaredField("address");
            addressField.trySetAccessible();
        } catch(SecurityException e) {
        } catch(NoSuchFieldException e) {
        }
    }

    /**
     * build the dataaddress with the correct type
     * @param builder
     * @return built dataaddress without additional logic
     */
    public static DataAddress build(DataAddress.Builder builder) {
        if(addressField!=null) {
            try {
                return (DataAddress) addressField.get(builder);
            } catch(IllegalAccessException e) {
            } 
        } 
        return builder.build();
    }
}
