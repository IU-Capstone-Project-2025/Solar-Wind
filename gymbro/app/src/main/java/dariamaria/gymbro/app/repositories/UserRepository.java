package dariamaria.gymbro.app.repositories;

import dariamaria.gymbro.app.models.Users;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<Users, Long> {
}
