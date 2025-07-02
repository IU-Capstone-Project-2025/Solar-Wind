package dariamaria.gymbro.app.services;

import com.solarwind.models.SportEntity;
import com.solarwind.repositories.SportRepository;
import dariamaria.gymbro.app.services.implementation.SportManagementServiceImp;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.List;

@ExtendWith(MockitoExtension.class)
public class SportManagementServiceTest {
    @Mock
    private SportRepository sportRepository;
    @InjectMocks
    private SportManagementServiceImp sportService;

    @Test
    public void shouldReturnPaginationSports() {
        int page = 1, size = 3;
        List<SportEntity> sports = getSports();
        Mockito.when(sportRepository.findAll()).thenReturn(sports);
        List<SportEntity> result = sportService.getPartOfSports(page, size);

        Assertions.assertNotNull(result);
        Assertions.assertEquals(3, result.size());
        Assertions.assertEquals(sports.get(3), result.get(0));
        Assertions.assertEquals(sports.get(4), result.get(1));
        Assertions.assertEquals(sports.get(5), result.get(2));
    }

    private List<SportEntity> getSports() {
        SportEntity sport1 = new SportEntity();
        SportEntity sport2 = new SportEntity();
        SportEntity sport3 = new SportEntity();
        SportEntity sport4 = new SportEntity();
        SportEntity sport5 = new SportEntity();
        SportEntity sport6 = new SportEntity();
        SportEntity sport7 = new SportEntity();

        sport1.setSportType("Танцы");
        sport2.setSportType("Борьба на шпагах");
        sport3.setSportType("Борьба");
        sport3.setSportType("Борьба");
        sport3.setSportType("Борьба");
        sport3.setSportType("Борьба");
        sport3.setSportType("Борьба");


        return List.of(sport1, sport2, sport3, sport4, sport5, sport6, sport7);
    }
}
