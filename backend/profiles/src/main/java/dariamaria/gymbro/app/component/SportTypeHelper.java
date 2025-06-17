package dariamaria.gymbro.app.component;

import com.solarwind.models.SportTypes;
import com.solarwind.models.UserEntity;
import org.springframework.stereotype.Component;

import java.util.Set;
import java.util.stream.Collectors;

@Component
public class SportTypeHelper {

    private final SportTypeRepository sportTypeRepository;

    public SportTypeHelper(SportTypeRepository sportTypeRepository) {
        this.sportTypeRepository = sportTypeRepository;
    }

    public Set<String> getSportNames(UserEntity user) {
        return user.getSports().stream()
                .map(SportTypes::getName)
                .collect(Collectors.toSet());
    }

    public SportTypes getByName(String name) {
        return sportTypeRepository.findByName(name)
                .orElseThrow(() -> new RuntimeException("Sport type not found: " + name));
    }
}