package dariamaria.gymbro.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = {"com.solarwind.repositories"})
@EntityScan(basePackages = {"com.solarwind.models"})
@ComponentScan(basePackages = {"com.solarwind", "com.solarwind.services", "com.solarwind.mappers", "dariamaria.gymbro.app"})
public class ProfileApplication {

	public static void main(String[] args) {
		SpringApplication.run(ProfileApplication.class, args);
	}

}
