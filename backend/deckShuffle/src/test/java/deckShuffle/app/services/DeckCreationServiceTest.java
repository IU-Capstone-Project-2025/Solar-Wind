package deckShuffle.app.services;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.ProfileMapper;
import com.solarwind.mappers.UserMapper;
import com.solarwind.models.CityEntity;
import com.solarwind.models.Gender;
import com.solarwind.models.UserEntity;
import com.solarwind.repositories.UserRepository;
import deckShuffle.app.services.implementation.DeckCreationServiceImp;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.eq;
import static org.mockito.Mockito.times;

@ExtendWith(MockitoExtension.class)
public class DeckCreationServiceTest {
    @Mock
    private UserRepository repository;

    @Mock
    private ProfileMapper profileMapper;

    @Mock
    private UserMapper userMapper;

    @InjectMocks
    private DeckCreationServiceImp deckService;

    @Test
    public void shouldReturnDeck() {
        UserEntity entity = new UserEntity();
        CityEntity city = new CityEntity();
        city.setCityName("Абаза");

        entity.setUsername("Test2");
        entity.setAge(10);
        entity.setGender(Gender.MALE);
        entity.setPreferredGender(Gender.FEMALE);
        entity.setCity(city);

        UserDto dto1 = new UserDto();
        dto1.setId(1L);
        dto1.setUsername("Test");
        dto1.setAge(10);
        dto1.setGender(Gender.MALE);
        dto1.setPreferredGender(Gender.FEMALE);
        dto1.setCityId(1L);

        UserEntity entity2 = new UserEntity();
        entity2.setUsername("Test2");
        entity2.setAge(10);
        entity2.setGender(Gender.MALE);
        entity2.setPreferredGender(Gender.FEMALE);
        entity2.setCity(city);

        Mockito.when(repository.findById(1L)).thenReturn(Optional.of(entity));
        Mockito.when(userMapper.mapToUsersDto(entity)).thenReturn(dto1);
        Mockito.when(repository.createDeckAllSettings(
                eq(dto1.getGender().toString()),
                eq(dto1.getPreferredGender().toString()),
                eq(dto1.getCityId()),
                eq(dto1.getAge()),
                eq(dto1.getId())))
                .thenReturn(List.of(entity, entity2));

        ProfileDto profile1 = new ProfileDto();
        ProfileDto profile2 = new ProfileDto();

        Mockito.when(profileMapper.mapToProfileDto(entity)).thenReturn(profile1);
        Mockito.when(profileMapper.mapToProfileDto(entity2)).thenReturn(profile2);

        List<ProfileDto> result = deckService.createDeck(1L);

        Assertions.assertNotNull(result);
        Assertions.assertEquals(2, result.size());
        Assertions.assertTrue(result.contains(profile1));
        Assertions.assertTrue(result.contains(profile2));

        Mockito.verify(repository).findById(1L);
        Mockito.verify(userMapper).mapToUsersDto(entity);
        Mockito.verify(repository).createDeckAllSettings(
                eq(dto1.getGender().toString()),
                eq(dto1.getPreferredGender().toString()),
                eq(dto1.getCityId()),
                eq(dto1.getAge()),
                eq(dto1.getId()));
        Mockito.verify(profileMapper, times(2)).mapToProfileDto(any(UserEntity.class));
    }
}
