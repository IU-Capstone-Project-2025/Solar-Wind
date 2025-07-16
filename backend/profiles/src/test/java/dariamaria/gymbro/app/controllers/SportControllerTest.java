package dariamaria.gymbro.app.controllers;

import com.solarwind.models.SportEntity;
import dariamaria.gymbro.app.services.implementation.SportManagementServiceImp;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.List;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
class SportControllerTest {

    private MockMvc mockMvc;

    @Mock
    private SportManagementServiceImp sportService;

    @InjectMocks
    private SportController controller;

    @BeforeEach
    void setup() {
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    void testGetSports() throws Exception {
        SportEntity sport1 = new SportEntity();
        sport1.setSportType("Акробатика");
        SportEntity sport2 = new SportEntity();
        sport2.setSportType("Бокс");
        List<SportEntity> sports = List.of(sport1, sport2);

        Mockito.when(sportService.getSports()).thenReturn(sports);

        mockMvc.perform(get("/api/sports"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(MediaType.APPLICATION_JSON))
                .andExpect(jsonPath("$[0].sportType").value("Акробатика"))
                .andExpect(jsonPath("$[1].sportType").value("Бокс"));
    }

}