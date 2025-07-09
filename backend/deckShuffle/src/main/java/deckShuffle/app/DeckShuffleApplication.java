package deckShuffle.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableCaching
@EnableJpaRepositories(basePackages = {"com.solarwind.repositories", "com.solarwind.securityModule.repositories"})
@EntityScan(basePackages = {"com.solarwind.models", "com.solarwind.securityModule.models"})
@ComponentScan(basePackages = {"com.solarwind", "com.solarwind.services", "com.solarwind.mappers", "deckShuffle.app"})
public class DeckShuffleApplication {

	public static void main(String[] args) {
		SpringApplication.run(DeckShuffleApplication.class, args);
	}

}
