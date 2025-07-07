package com.solarwind.securityModule.config;

import jakarta.persistence.EntityManagerFactory;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.orm.jpa.JpaTransactionManager;
import org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean;
import org.springframework.orm.jpa.vendor.HibernateJpaVendorAdapter;
import org.springframework.transaction.PlatformTransactionManager;

import javax.sql.DataSource;

@Configuration
@EnableJpaRepositories(
        basePackages = "com.solarwind.securityModule", // путь к твоим репозиториям
        entityManagerFactoryRef = "securityEntityManagerFactory",
        transactionManagerRef = "securityTransactionManager"
)
public class SecurityJpaConfig {

    @Bean
    public LocalContainerEntityManagerFactoryBean securityEntityManagerFactory(
            @Qualifier("securityDataSource") DataSource dataSource) {
        LocalContainerEntityManagerFactoryBean em = new LocalContainerEntityManagerFactoryBean();
        em.setDataSource(dataSource);
        em.setPackagesToScan("com.example.securitymodule.models");
        em.setPersistenceUnitName("security");

        HibernateJpaVendorAdapter vendorAdapter = new HibernateJpaVendorAdapter();
        em.setJpaVendorAdapter(vendorAdapter);
        return em;
    }

    @Bean
    public PlatformTransactionManager securityTransactionManager(
            @Qualifier("securityEntityManagerFactory") EntityManagerFactory factory) {
        return new JpaTransactionManager(factory);
    }
}
