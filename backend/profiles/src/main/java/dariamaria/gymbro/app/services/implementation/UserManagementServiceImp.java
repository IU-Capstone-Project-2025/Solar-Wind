package dariamaria.gymbro.app.services.implementation;

import com.solarwind.dto.UserDto;
import com.solarwind.models.UserEntity;
import com.solarwind.services.implementations.UserRetrievalServiceImp;
import dariamaria.gymbro.app.services.UserManagementService;
import org.springframework.stereotype.Service;

@Service
public class UserManagementServiceImp extends UserRetrievalServiceImp implements UserManagementService {
    @Override
    public UserDto createUser(UserDto dto) {
        UserEntity user = mapper.mapToUsersEntity(dto);
        repository.save(user);
        return dto;
    }

    @Override
    public void deleteUserById(long id) {
        repository.deleteById(id);
    }
}
