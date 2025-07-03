package dariamaria.gymbro.app.services;

import com.solarwind.dto.UserDto;
import com.solarwind.mappers.UserMapper;
import com.solarwind.models.UserEntity;
import com.solarwind.repositories.UserRepository;
import dariamaria.gymbro.app.services.implementation.UserManagementServiceImp;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

@ExtendWith(MockitoExtension.class)
public class UserManagementServiceTest {
    @Mock
    private UserRepository repository;
    @Mock
    private UserMapper mapper;
    @InjectMocks
    private UserManagementServiceImp userService;

    @Test
    public void shouldReturnId() {
        String newUsename = "testuser1";
        long userId = 13L;
        UserDto dto = new UserDto();
        dto.setUsername(newUsename);
        UserEntity entity = new UserEntity();
        entity.setUsername(newUsename);

        Mockito.when(mapper.mapToUsersEntity(dto)).thenReturn(entity);
        Mockito.when(repository.findIdByUsername(newUsename)).thenReturn(userId);

        Long result = userService.createUser(dto);

        Assertions.assertNotNull(result);
        Assertions.assertEquals(userId, result);
    }

    @Test
    public void shouldDeleteUserById() {
        long userId = 13L;
        userService.deleteUserById(userId);
        Mockito.verify(repository).deleteById(userId);
    }
}
