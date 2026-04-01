package com.embabel.demo.config;

import com.nimbusds.jose.JOSEException;
import com.nimbusds.jose.jwk.RSAKey;
import com.nimbusds.jose.jwk.gen.RSAKeyGenerator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.oauth2.jwt.JwtDecoder;
import org.springframework.security.oauth2.jwt.NimbusJwtDecoder;
import org.springframework.security.web.SecurityFilterChain;

/**
 * Development security configuration that provides a local RSA-based JwtDecoder.
 * <p>
 * This avoids the need for an external OAuth2 identity provider during development.
 * The generated RSA key pair is ephemeral — it is recreated on each application restart.
 * <p>
 * For production, replace this with a proper issuer-uri configuration, for example, a Microsoft Entra ID App Registration usign OAuth2:
 * <pre>
 * spring.security.oauth2.resourceserver.jwt.issuer-uri=https://your-idp.example.com
 * </pre>
 */
@Configuration
public class SecurityConfiguration {

    private static final Logger LOG = LoggerFactory.getLogger(SecurityConfiguration.class);

    private final RSAKey rsaKey;

    public SecurityConfiguration() throws JOSEException {
        this.rsaKey = new RSAKeyGenerator(2048)
                .keyID("dev-key")
                .generate();
        LOG.info("Generated ephemeral RSA key pair for local JWT validation (key ID: {})", rsaKey.getKeyID());
    }

    @Bean
    @Order(1)
    public SecurityFilterChain registerFilterChain(HttpSecurity http) throws Exception {
        return http
                .securityMatcher("/register")
                .authorizeHttpRequests(auth -> auth.anyRequest().permitAll())
                .csrf(csrf -> csrf.disable())
                .build();
    }

    @Bean
    @ConditionalOnMissingBean
    public JwtDecoder jwtDecoder() throws JOSEException {
        return NimbusJwtDecoder.withPublicKey(rsaKey.toRSAPublicKey()).build();
    }

    /**
     * Exposes the RSA key so that tokens can be signed for testing.
     */
    @Bean
    public RSAKey rsaKey() {
        return rsaKey;
    }
}
