package dariamaria.gymbro.app.services;

import com.solarwind.models.CityEntity;
import com.solarwind.repositories.CityRepository;
import dariamaria.gymbro.app.services.implementation.CityManagementServiceImp;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

@ExtendWith(MockitoExtension.class)
public class CityManagementServiceTest {
    @Mock
    private CityRepository cityRepository;
    @InjectMocks
    private CityManagementServiceImp cityService;

    @Test
    public void shouldReturnPaginationCities() {
        int page = 1, size = 2;
        List<CityEntity> cities = getCities();

        Mockito.when(cityRepository.findAll()).thenReturn(cities);
        List<CityEntity> result = cityService.getPartOfCities(page, size);

        Assertions.assertNotNull(result);
        Assertions.assertEquals(2, result.size());
        Assertions.assertEquals(cities.get(2), result.get(0));
        Assertions.assertEquals(cities.get(3), result.get(1));
    }

    private List<CityEntity> getCities() {
        CityEntity city1 = new CityEntity();
        CityEntity city2 = new CityEntity();
        CityEntity city3 = new CityEntity();
        CityEntity city4 = new CityEntity();
        CityEntity city5 = new CityEntity();

        city1.setCityName("Inno");
        city2.setCityName("Арзамас");
        city3.setCityName("Калуга");
        city4.setCityName("Москва");
        city5.setCityName("Нижний Новгород");

        return List.of(city1, city2, city3, city4, city5);
    }
}
