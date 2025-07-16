package deckShuffle.app.services;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.UserMapper;
import com.solarwind.models.CityEntity;
import com.solarwind.models.Gender;
import com.solarwind.models.UserEntity;
import com.solarwind.repositories.UserRepository;
import deckShuffle.app.services.implementation.DeckCacheableService;
import deckShuffle.app.services.implementation.DeckCreationServiceImp;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import static org.mockito.ArgumentMatchers.eq;

@ExtendWith(MockitoExtension.class)
public class DeckCreationServiceTest {

    @Mock
    private UserRepository repository;

    @Mock
    private UserMapper userMapper;

    @Mock
    private DeckCacheableService deckCacheableService;

    @InjectMocks
    private DeckCreationServiceImp deckService;

    @Test
    public void shouldReturnDeck() {
        UserEntity entity = new UserEntity();
        CityEntity city = new CityEntity();
        city.setCityName("Абаза");

        entity.setUsername("Test2");
        entity.setAge(LocalDate.ofEpochDay(2005-12-06));
        entity.setGender(Gender.MALE);
        entity.setPreferredGender(Gender.FEMALE);
        entity.setCity(city);

        UserDto dto1 = new UserDto();
        dto1.setId(1L);
        dto1.setUsername("Test");
        dto1.setAge(LocalDate.ofEpochDay(2005-12-06));
        dto1.setGender(Gender.MALE);
        dto1.setPreferredGender(Gender.FEMALE);
        dto1.setCityId(1L);

        List<ProfileDto> expectedDeck = List.of(new ProfileDto(), new ProfileDto());

        Mockito.when(repository.findById(1L)).thenReturn(Optional.of(entity));
        Mockito.when(userMapper.mapToUsersDto(entity)).thenReturn(dto1);
        Mockito.when(deckCacheableService.getOrCreateDeck(eq(dto1))).thenReturn(expectedDeck);

        List<ProfileDto> result = deckService.createDeck(1L);

        Assertions.assertNotNull(result);
        Assertions.assertEquals(2, result.size());
        Assertions.assertEquals(expectedDeck, result);

        Mockito.verify(repository).findById(1L);
        Mockito.verify(userMapper).mapToUsersDto(entity);
        Mockito.verify(deckCacheableService).getOrCreateDeck(eq(dto1));
    }
}
