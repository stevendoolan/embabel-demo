package com.embabel.demo.config;

import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.JWSAlgorithm;
import com.nimbusds.jose.JWSHeader;
import com.nimbusds.jose.crypto.RSASSASigner;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.Instant;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Development-only endpoint that mints JWTs signed with the ephemeral RSA key.
 * <p>
 * Usage:
 * <pre>
 * curl -X POST http://localhost:8080/register \
 *   -H "Content-Type: application/json" \
 *   -d '{"subject": "test-client", "authorities": ["news:read", "market:admin"]}'
 * </pre>
 * The returned token can be used as a Bearer token for secured MCP endpoints.
 */
@RestController
public class DevTokenController {

    private final RSAKey rsaKey;

    public DevTokenController(RSAKey rsaKey) {
        this.rsaKey = rsaKey;
    }

    @PostMapping("/register")
    public Map<String, String> register(@RequestBody RegisterRequest request) throws JOSEException {
        Instant now = Instant.now();

        JWTClaimsSet claims = new JWTClaimsSet.Builder()
                .subject(request.subject() != null ? request.subject() : "dev-client")
                .issuer("embabel-demo-dev")
                .issueTime(Date.from(now))
                .expirationTime(Date.from(now.plusSeconds(86400))) // 24 hours
                .claim("scope", request.authorities() != null ? String.join(" ", request.authorities()) : "")
                .build();

        SignedJWT signedJWT = new SignedJWT(
                new JWSHeader.Builder(JWSAlgorithm.RS256).keyID(rsaKey.getKeyID()).build(),
                claims
        );
        signedJWT.sign(new RSASSASigner(rsaKey));

        return Map.of(
                "access_token", signedJWT.serialize(),
                "token_type", "Bearer",
                "expires_in", "86400"
        );
    }

    public record RegisterRequest(String subject, List<String> authorities) {}
}
