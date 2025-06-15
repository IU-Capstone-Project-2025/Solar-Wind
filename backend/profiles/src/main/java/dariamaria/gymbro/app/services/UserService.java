package dariamaria.gymbro.app.services;

import com.solarwind.dto.UsersDto;

import java.util.List;

public interface UserService {
    UsersDto createUser(UsersDto dto);
    UsersDto getByUserId(long id);
    List<UsersDto> getUsers();

    void deleteUserById(long id);
}
