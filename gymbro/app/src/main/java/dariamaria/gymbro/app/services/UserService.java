package dariamaria.gymbro.app.services;

import dariamaria.gymbro.app.dto.UsersDto;

import java.util.List;

public interface UserService {
    UsersDto createUser(UsersDto dto);
    UsersDto getByUserId(long id);
    List<UsersDto> getUsers();

    void deleteUserById(long id);
}
