//
// EDC JWT Auth Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package org.eclipse.tractusx.edc.auth;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSVerifier;
import com.nimbusds.jose.crypto.ECDSAVerifier;
import com.nimbusds.jose.crypto.RSASSAVerifier;
import com.nimbusds.jose.jca.JCAContext;
import com.nimbusds.jose.jwk.ECKey;
import com.nimbusds.jose.jwk.OctetSequenceKey;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jose.util.Base64URL;
import com.nimbusds.jose.util.IOUtils;

import java.io.IOException;
import java.io.InputStream;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

/**
 * A composite verifier that
 * sits on top of a set of keys/verifiers
 * provided by different sources
 */
public class CompositeJwsVerifier implements JWSVerifier {

    final protected Map<JWSAlgorithm, JWSVerifier> verifierMap=new HashMap<>();

    public CompositeJwsVerifier() {
    }

    @Override
    public boolean verify(JWSHeader jwsHeader, byte[] bytes, Base64URL base64URL) throws JOSEException {
        return verifierMap.get(jwsHeader.getAlgorithm()).verify(jwsHeader,bytes,base64URL);
    }

    @Override
    public Set<JWSAlgorithm> supportedJWSAlgorithms() {
        return verifierMap.keySet();
    }

    @Override
    public JCAContext getJCAContext() {
        return verifierMap.entrySet().stream().findFirst().map(e->e.getValue().getJCAContext()).orElse(null);
    }

    /**
     * a builder for composite jws verifiers
     */
    public static class Builder {
        protected CompositeJwsVerifier verifier;
        final protected ObjectMapper om;

        public Builder(ObjectMapper om) {
            verifier=new CompositeJwsVerifier();
            this.om=om;
        }

        public Builder addVerifier(JWSVerifier subVerifier) {
            subVerifier.supportedJWSAlgorithms().forEach(algo -> verifier.verifierMap.put(algo,subVerifier));
            return this;
        }

        /**
         * adds a key as a json node
         * @param key json representation of keys
         * @return this builder
         */
        public Builder addKey(JsonNode key) {
            if (key.has("keys")) {
                key = key.get("keys");
            }
            if (key.isArray()) {
                var keyIterator = key.elements();
                while (keyIterator.hasNext()) {
                    JsonNode nextKey= keyIterator.next();
                    if(nextKey.has("use") && nextKey.get("use").asText().equals("sig")) {
                        addKey(nextKey);
                    }
                }
                return this;
            }
            if ( key.has("kty")) {
                var kty = key.get("kty");
                switch (kty.asText()) {
                    case "RSA":
                        try {
                            var rsaKey = RSAKey.parse(om.writeValueAsString(key));
                            return addVerifier(new RSASSAVerifier(rsaKey));
                        } catch(JOSEException | JsonProcessingException | ParseException e) {
                        }
                    case "EC":
                        try {
                            var ecKey = ECKey.parse(om.writeValueAsString(key));
                            return addVerifier(new ECDSAVerifier(ecKey));
                        } catch(JOSEException | JsonProcessingException | ParseException e) {
                        }
                    default:
                        break;
                }
            }
            return this;
        }

        /**
         * adds s given key
         * @param key maybe a a json definition for a single key or multiple keys, or a url to download a key
         * @return this instance
         */
        public Builder addKey(String key) {
            if(key!=null) {
                try {
                    URL keyUrl = new URL(key);
                    try (InputStream keyStream = keyUrl.openStream()) {
                        key = IOUtils.readInputStreamToString(keyStream);
                    } catch (IOException e) {
                        key = null;
                    }
                } catch (MalformedURLException e) {
                }
            }
            if(key!=null) {
                try {
                    return addKey(om.readTree(key));
                } catch (JsonProcessingException e) {
                }
            }
            return this;
        }

        public CompositeJwsVerifier build() {
            return verifier;
        }
    }
}
