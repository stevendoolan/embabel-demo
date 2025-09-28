package com.embabel.demo.config;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

// TODO I did try to make an EnvironmentPostProcessor, but I could not make it work.

/**
 * Sets up proxy settings for this application, reading from System Environment Variables:
 * <pre>
 *     export HTTP_PROXY=http://proxy.example.com:8080
 *     export HTTPS_PROXY=https://proxy.example.com:443
 *     export NO_PROXY=localhost,*.example.com
 * </pre>
 *
 * Proxy properties set:
 * <pre>
 *     http.proxy.host      = proxy.example.com
 *     http.proxy.port      = 8080
 *     http.proxyHost       = proxy.example.com
 *     http.proxyPort       = 8080
 *     https.proxy.host     = proxy.example.com
 *     https.proxy.port     = 443
 *     https.proxyHost      = proxy.example.com
 *     https.proxyPort      = 443
 *     http.nonProxyHosts   = localhost|*.example.com
 *     https.nonProxyHosts  = localhost|*.example.com
 * </pre>
 *
 * If these are not set, no proxy settings are applied.
 */
public class ProxyConfigurer {

    private static final Logger LOG = LoggerFactory.getLogger(ProxyConfigurer.class);

    private static final String HTTPS_PROXY_ENVIRONMENT_VARIABLE = "HTTPS_PROXY";
    private static final String HTTP_PROXY_ENVIRONMENT_VARIABLE = "HTTP_PROXY";

    private static final Pattern PROXY_PATTERN = Pattern.compile("^(http|https)://(?<host>[^:/]+)(:(?<port>\\d+))?$");

    private static final String HOST_GROUP = "host";
    private static final String PORT_GROUP = "port";
    public static final String NO_PROXY_ENVIRONMENT_VARIABLE = "NO_PROXY";

    public static void configureProxy() {
        configureHttpProxy();
        configureHttpsProxy();
        configureNoProxy();
    }

    private static void configureHttpProxy() {
        String httpProxy = System.getenv(HTTP_PROXY_ENVIRONMENT_VARIABLE);
        if (StringUtils.isNotBlank(httpProxy)) {
            LOG.info("Using HTTP proxy: {}", httpProxy);
            Matcher matcher = PROXY_PATTERN.matcher(StringUtils.trim(httpProxy));
            if (matcher.matches()) {
                String host = matcher.group(HOST_GROUP);
                String port = matcher.group(PORT_GROUP);
                System.setProperty("http.proxy.host", host);
                System.setProperty("http.proxy.port", port);
                LOG.info("Set http.proxy.host={}, http.proxy.port={}", host, port);

                System.setProperty("http.proxyHost", host);
                System.setProperty("http.proxyPort", port);
                LOG.info("Set http.proxyHost={}, http.proxyPort={}", host, port);
            }
        } else {
            LOG.info("No HTTP proxy configured");
        }
    }

    private static void configureHttpsProxy() {
        String httpsProxy = System.getenv(HTTPS_PROXY_ENVIRONMENT_VARIABLE);
        if (StringUtils.isNotBlank(httpsProxy)) {
            LOG.info("Using HTTPS proxy: {}", httpsProxy);
            Matcher matcher = PROXY_PATTERN.matcher(StringUtils.trim(httpsProxy));
            if (matcher.matches()) {
                String host = matcher.group(HOST_GROUP);
                String port = matcher.group(PORT_GROUP);

                System.setProperty("https.proxy.host", host);
                System.setProperty("https.proxy.port", port);
                LOG.info("Set https.proxy.host={}, https.proxy.port={}", host, port);

                System.setProperty("https.proxyHost", host);
                System.setProperty("https.proxyPort", port);
                LOG.info("Set https.proxyHost={}, https.proxyPort={}", host, port);
            }
        } else {
            LOG.info("No HTTPS proxy configured");
        }
    }

    /**
     * Convert NO_PROXY format (comma-separated) to Java format (pipe-separated).
     */
    private static void configureNoProxy() {
        String noProxy = System.getenv(NO_PROXY_ENVIRONMENT_VARIABLE);
        if (StringUtils.isNotBlank(noProxy)) {
            LOG.info("Using NO_PROXY: {}", noProxy);
            String nonProxyHosts = noProxy.replace(",", "|").replace(" ", "");
            System.setProperty("http.nonProxyHosts", nonProxyHosts);
            LOG.info("Set http.nonProxyHosts={}", nonProxyHosts);
            System.setProperty("https.nonProxyHosts", nonProxyHosts);
            LOG.info("Set https.nonProxyHosts={}", nonProxyHosts);
        } else {
            LOG.info("No NO_PROXY configured");
        }
    }
}
