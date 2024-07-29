package com.sap.bookshop.controller;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.RestController;

import com.sap.cloud.security.client.HttpClientFactory;
import com.sap.cloud.security.config.OAuth2ServiceConfiguration;
import com.sap.cloud.security.config.OAuth2ServiceConfigurationBuilder;
import com.sap.cloud.security.xsuaa.client.DefaultOAuth2TokenService;
import com.sap.cloud.security.xsuaa.client.OAuth2TokenResponse;
import com.sap.cloud.security.xsuaa.client.XsuaaDefaultEndpoints;
import com.sap.cloud.security.xsuaa.tokenflows.XsuaaTokenFlows;
import com.sap.xs.env.Credentials;
import com.sap.xs.env.Service;
import com.sap.xs.env.VcapServices;

import cds.gen.bookshop1.Books;

import org.apache.http.HttpHeaders;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
public class BooksController {

    private XsuaaTokenFlows xsuaaTokenFlows;
    private String xsuaaToken;

    private static Logger logger = LoggerFactory.getLogger(BooksController.class);

    @GetMapping(value = "/sdk")
    public String getBooks(){
        try{
            logger.info("Controller Called");
            String accessToken = getXSUAAAccessToken();
            logger.info("Token fetched {}", accessToken);
            CloseableHttpClient httpClient = HttpClients.createDefault();

            // Create a GET request
            HttpGet request = new HttpGet("https://rmtest-rmcfkvpr-myspace-bookshop1-srv.cfapps.sap.hana.ondemand.com/odata/v4/Bookshop1/Books");

            request.setHeader(HttpHeaders.AUTHORIZATION, "Bearer" + accessToken);
            // Execute the request
            CloseableHttpResponse response = httpClient.execute(request);

            // Parse the response
            String jsonResponse = EntityUtils.toString(response.getEntity());

            response.close();
            httpClient.close();
            return jsonResponse;
        }catch(Exception e){
            return e.getMessage();
        }
    }

        private String getXSUAAAccessToken() {


        OAuth2TokenResponse tokenResponse = null;
        final XsuaaTokenFlows tokenFlows = getTokenFlow();

        if (tokenFlows != null) {
            try {
                tokenResponse = tokenFlows.clientCredentialsTokenFlow().execute();
            } catch (final Exception exception) {
            }

            if (tokenResponse != null) {
                final String accessToken = tokenResponse.getAccessToken();
                final String tokenType = tokenResponse.getTokenType();
                xsuaaToken = tokenType.concat(" ").concat(accessToken);
                return xsuaaToken;
            }
        }
        return null;
    }


    private XsuaaTokenFlows getTokenFlow(){
        final VcapServices vcapServices = VcapServices.fromEnvironment();
        if (vcapServices != null) {
            final Service service = vcapServices.findService("xsuaa", null, null);
            if (service != null) {
                logger.info("XSUAA FOUND");
                final Credentials credentials = service.getCredentials();
                final OAuth2ServiceConfigurationBuilder builder = OAuth2ServiceConfigurationBuilder
                        .forService(com.sap.cloud.security.config.Service.XSUAA);
                if (credentials != null) {
                    final OAuth2ServiceConfiguration configuration = getOAuth2ServiceConfiguration(credentials, builder);
                    xsuaaTokenFlows = new XsuaaTokenFlows(
                            new DefaultOAuth2TokenService(HttpClientFactory.create(configuration.getClientIdentity())),
                            new XsuaaDefaultEndpoints(configuration), configuration.getClientIdentity());
                            return xsuaaTokenFlows;
                }
            }else{
                logger.info("XSUAA NOT FOUND");
            }
        }

        return null;
    }

    private OAuth2ServiceConfiguration getOAuth2ServiceConfiguration(final Credentials credentials,
    final OAuth2ServiceConfigurationBuilder builder) {
        final String clientId = (String) credentials.get("clientid");
        final String clientSecret = (String) credentials.get("clientsecret");
        final String certificate = (String) credentials.get("certificate");
        final String privateKey = (String) credentials.get("key");
        final String url = (String) credentials.get("url");
        final String certurl = (String) credentials.get("certurl");
        return builder.withClientId(clientId).withClientSecret(clientSecret).withCertificate(certificate).withPrivateKey(privateKey)
                .withUrl(url).withCertUrl(certurl).build();
}


}
