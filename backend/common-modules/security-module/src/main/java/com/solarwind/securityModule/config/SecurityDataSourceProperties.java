package com.solarwind.securityModule.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@Configuration
@ConfigurationProperties(prefix = "securitymodule.datasource")
public class SecurityDataSourceProperties {
    private String url;
    private String username;
    private String password;
    private String driverClassName;
}
