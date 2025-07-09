package likes.app;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories(basePackages = {"com.solarwind.repositories", "com.solarwind.securityModule.repositories"})
@EntityScan(basePackages = {"com.solarwind.models", "com.solarwind.securityModule.models"})
@ComponentScan(basePackages = {"com.solarwind", "likes.app"})
public class LikesApplication {

	public static void main(String[] args) {
		SpringApplication.run(LikesApplication.class, args);
	}

}
