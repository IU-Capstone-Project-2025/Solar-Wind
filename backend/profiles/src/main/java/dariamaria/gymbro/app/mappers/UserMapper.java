package dariamaria.gymbro.app.mappers;

import com.solarwind.dto.UsersDto;
import com.solarwind.models.SportTypes;
import com.solarwind.models.Users;
import dariamaria.gymbro.app.repositories.SportTypeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class UserMapper {
    private final SportTypeRepository sportTypeRepository;
    public UsersDto mapToUsersDto(Users user) {
        UsersDto dto = new UsersDto();
        dto.setId(user.getId());
        dto.setTelegramId(user.getTelegramId());
        dto.setUsername(user.getUsername());
        dto.setFirstName(user.getFirstName());
        dto.setLastName(user.getLastName());
        dto.setAge(user.getAge());
        dto.setGender(user.getGender());
        dto.setVerified(user.getVerified());
        dto.setPreferredGender(user.getPreferredGender());
        dto.setCity(user.getCity());
        dto.setPreferredGymTime(user.getPreferredGymTime());
        dto.setSportNames(user.getSports()
                .stream()
                .map(SportTypes::getName)
                .collect(Collectors.toSet()));
        return dto;
    }
    public Users mapToUsersEntity(UsersDto dto) {
        Users user = new Users();
        user.setTelegramId(dto.getTelegramId());
        user.setUsername(dto.getUsername());
        user.setFirstName(dto.getFirstName());
        user.setLastName(dto.getLastName());
        user.setAge(dto.getAge());
        user.setGender(dto.getGender());
        user.setPreferredGender(dto.getPreferredGender());
        user.setCity(dto.getCity());
        user.setPreferredGymTime(dto.getPreferredGymTime());
        user.setSports(
                dto.getSportNames().stream()
                        .map(name -> sportTypeRepository.findByName(name)
                                .orElseThrow(() -> new RuntimeException("Sport type not found: " + name)))
                        .collect(Collectors.toSet())
        );
        user.setVerified(dto.getVerified());
        return user;
    }
}
