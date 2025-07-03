package dariamaria.gymbro.app.controllers;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;
import dariamaria.gymbro.app.services.implementation.CityManagementServiceImp;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;

@ExtendWith(MockitoExtension.class)
class CityControllerTest {

    private MockMvc mockMvc;

    @Mock
    private CityManagementServiceImp cityService;

    @InjectMocks
    private CityController controller;

    @BeforeEach
    void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    void testGetSports() throws Exception {
        CityEntity city1 = new CityEntity();
        city1.setCityName("Иннополис");
        CityEntity city2 = new CityEntity();
        city2.setCityName("Нижний Новгород");
        List<CityEntity> cities = List.of(city1, city2);

        Mockito.when(cityService.getCities()).thenReturn(cities);

        mockMvc.perform(get("/api/cities"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$[0].cityName").value("Иннополис"))
                .andExpect(jsonPath("$[1].cityName").value("Нижний Новгород"));
    }

}