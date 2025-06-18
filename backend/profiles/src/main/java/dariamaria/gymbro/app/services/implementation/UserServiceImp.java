package dariamaria.gymbro.app.services.implementation;

import com.solarwind.dto.UserDto;
import com.solarwind.models.UserEntity;
import dariamaria.gymbro.app.mappers.UserMapper;
import dariamaria.gymbro.app.repositories.UserRepository;
import dariamaria.gymbro.app.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserServiceImp implements UserService {
    @Autowired
    private UserRepository repository;
    @Autowired
    private UserMapper mapper;
    @Override
    public UserDto createUser(UserDto dto) {
        UserEntity user = mapper.mapToUsersEntity(dto);
        repository.save(user);
        return dto;
    }
    @Override
    public UserDto getByUserId(long id) {
        return mapper.mapToUsersDto(repository.getById(id));
    }

    @Override
    public List<UserDto> getUsers() {
        return repository.findAll()
                .stream()
                .map(user -> mapper.mapToUsersDto(user))
                .collect(Collectors.toList());
    }

    @Override
    public void deleteUserById(long id) {
        repository.deleteById(id);
    }
}
