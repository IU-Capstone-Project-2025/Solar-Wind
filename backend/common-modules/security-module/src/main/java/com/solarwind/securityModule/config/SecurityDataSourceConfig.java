package com.solarwind.securityModule.config;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import javax.sql.DataSource;

@Configuration
@EnableConfigurationProperties(SecurityDataSourceProperties.class)
public class SecurityDataSourceConfig {

    @Bean(name = "securityDataSource")
    public DataSource securityDataSource(SecurityDataSourceProperties props) {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName(props.getDriverClassName());
        dataSource.setUrl(props.getUrl());
        dataSource.setUsername(props.getUsername());
        dataSource.setPassword(props.getPassword());
        return dataSource;
    }
}

