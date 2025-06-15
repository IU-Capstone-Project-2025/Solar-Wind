package dariamaria.gymbro.app.repositories;

import com.solarwind.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<Users, Long> {
}
