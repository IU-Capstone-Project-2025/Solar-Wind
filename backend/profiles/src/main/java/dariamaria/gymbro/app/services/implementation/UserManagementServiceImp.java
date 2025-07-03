package dariamaria.gymbro.app.services.implementation;

import com.solarwind.dto.UserDto;
import com.solarwind.mappers.UserMapper;
import com.solarwind.models.UserEntity;
import com.solarwind.services.implementations.UserRetrievalServiceImp;
import dariamaria.gymbro.app.services.UserManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
