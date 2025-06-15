package dariamaria.gymbro.app.repositories;

import com.solarwind.models.SportTypes;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface SportTypeRepository extends JpaRepository<SportTypes, Long> {
    Optional<SportTypes> findByName(String name);
}