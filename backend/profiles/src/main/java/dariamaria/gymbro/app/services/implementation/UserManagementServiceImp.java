package dariamaria.gymbro.app.services.implementation;

import com.solarwind.dto.UserDto;
import com.solarwind.models.UserEntity;
import com.solarwind.services.implementations.UserRetrievalServiceImp;
import dariamaria.gymbro.app.services.UserManagementService;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.Optional;

@Service
public class UserManagementServiceImp extends UserRetrievalServiceImp implements UserManagementService {
    @Override
    public Long createUser(UserDto dto) {
        UserEntity user = userMapper.mapToUsersEntity(dto);
        repository.save(user);
        return repository.findIdByUsername(user.getUsername());
    }

    @Override
    public void deleteUserById(long id) {
        repository.deleteById(id);
    }

    @Override
    public void updateUser(UserDto dto) {
        Optional<UserEntity> existing = repository.findById(dto.getId());
        if (existing.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User to update is not exists");
        }
        UserEntity user = existing.get();
        repository.delete(user);
        UserEntity toSave = userMapper.mapToUsersEntity(dto);
        repository.save(toSave);
    }
}
