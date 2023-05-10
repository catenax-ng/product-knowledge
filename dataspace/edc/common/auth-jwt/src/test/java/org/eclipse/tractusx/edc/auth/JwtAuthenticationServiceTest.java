//
// EDC JWT Auth Extension
// See copyright notice in the top folder
// See authors file in the top folder
// See license file in the top folder
//
package org.eclipse.tractusx.edc.auth;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.JWSSigner;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jose.jwk.gen.RSAKeyGenerator;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class JwtAuthenticationServiceTest {
    ObjectMapper om;

    CompositeJwsVerifier verifier;

    JwtAuthenticationService service;

    String token;
    String token2;

    @BeforeEach
    public void initialize() throws JOSEException {
        om=new ObjectMapper();
        RSAKey rsaJWK = new RSAKeyGenerator(2048)
                .keyID("123")
                .generate();
        RSAKey rsaPublicJWK = rsaJWK.toPublicJWK();
        JWSSigner signer = new RSASSASigner(rsaJWK);
        JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
                .subject("alice")
                .issuer("https://c2id.com")
                .expirationTime(new Date(1683529307))
                .issueTime(new Date(1683529007))
                .build();
        SignedJWT signedJWT = new SignedJWT(
                new JWSHeader.Builder(JWSAlgorithm.RS256).keyID(rsaJWK.getKeyID()).build(),
                claimsSet);
        signedJWT.sign(signer);
        token = signedJWT.serialize();
        RSAKey rsaJWK2 = new RSAKeyGenerator(2048)
                .keyID("456")
                .generate();
        JWSSigner signer2 = new RSASSASigner(rsaJWK2);
        SignedJWT signedJWT2 = new SignedJWT(
                new JWSHeader.Builder(JWSAlgorithm.RS256).keyID(rsaJWK2.getKeyID()).build(),
                claimsSet);
        signedJWT2.sign(signer2);
        token2 = signedJWT2.serialize();
        verifier=new CompositeJwsVerifier.Builder(om).addKey(rsaPublicJWK.toJSONString()).build();
        service=new JwtAuthenticationService(verifier,false);
    }

    @Test
    public void testValidJwtToken() {
        var headers=Map.of("Authorization", List.of("Bearer "+token));
        assertTrue(service.isAuthenticated(headers),"Could not authenticate using valid token");
    }

    @Test
    public void testValidOtherJwtToken() {
        var headers=Map.of("Authorization", List.of("Bearer "+token2));
        assertFalse(service.isAuthenticated(headers),"Could not authenticate using valid token");
    }

    @Test
    public void testInvalidJwtToken() {
        var headers=Map.of("Authorization", List.of("Bearer "+token.substring(10,20)));
        assertFalse(service.isAuthenticated(headers),"Could authenticate using invalid token");
    }

    @Test
    public void testInvalidHeader() {
        var headers=Map.of("Authorization", List.of("bullshit"));
        assertFalse(service.isAuthenticated(headers),"Could authenticate using invalid header");
    }

    @Test
    public void testExpiredJwtToken() {
        JwtAuthenticationService secondService=new JwtAuthenticationService(verifier,true);
        var headers=Map.of("Authorization", List.of("Bearer "+token));
        assertFalse(secondService.isAuthenticated(headers),"Could authenticate using expired token");
    }
}
