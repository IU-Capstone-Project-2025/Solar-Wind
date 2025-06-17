package dariamaria.gymbro.app.services;

import com.solarwind.dto.UserDto;

import java.util.List;

public interface UserService {
    UserDto createUser(UserDto dto);
    UserDto getByUserId(long id);
    List<UserDto> getUsers();

    void deleteUserById(long id);
}
