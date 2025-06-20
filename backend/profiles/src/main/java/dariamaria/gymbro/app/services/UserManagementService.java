package dariamaria.gymbro.app.services;

import com.solarwind.dto.UserDto;
import com.solarwind.services.UserRetrievalService;

public interface UserManagementService extends UserRetrievalService {
    UserDto createUser(UserDto dto);
    void deleteUserById(long id);
}
