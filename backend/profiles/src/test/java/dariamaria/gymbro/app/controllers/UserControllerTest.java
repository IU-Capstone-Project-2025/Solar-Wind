package dariamaria.gymbro.app.controllers;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import dariamaria.gymbro.app.services.UserManagementService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.verify;

import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import java.util.*;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@ExtendWith(MockitoExtension.class)
public class UserControllerTest {
    private MockMvc mockMvc;

    @Mock
    private UserManagementService service;

    @InjectMocks
    private UserController controller;

    private ObjectMapper objectMapper;

    @BeforeEach
    void setup() {
        objectMapper = new ObjectMapper();
        mockMvc = MockMvcBuilders.standaloneSetup(controller).build();
    }

    @Test
    void shouldCreateUser() throws Exception {
        UserDto dto = new UserDto();
        dto.setUsername("testuser");
        dto.setCityId(1L);
        dto.setSportId(List.of(1L));
        dto.setPreferredGymTime(List.of(1, 2, 3));
        Mockito.when(service.createUser(any(UserDto.class))).thenReturn(42L);

        mockMvc.perform(post("/api/me")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(dto)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(42));
    }

    @Test
    void shouldGetUserById() throws Exception {
        ProfileDto profile = new ProfileDto();
        profile.setUsername("testuser");
        Mockito.when(service.getByUserId(1L)).thenReturn(profile);

        mockMvc.perform(get("/api/me").header("Authorization-telegram-id", "1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.username").value("testuser"));
    }

    @Test
    void shouldReturnAllUsers() throws Exception {
        ProfileDto profile1 = new ProfileDto();
        profile1.setUsername("u1");
        ProfileDto profile2 = new ProfileDto();
        profile2.setUsername("u2");

        Mockito.when(service.getUsers()).thenReturn(List.of(profile1, profile2));

        mockMvc.perform(get("/api/getUsers"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.size()").value(2));
    }

    @Test
    void shouldDeleteUser() throws Exception {
        mockMvc.perform(delete("/api/me").param("id", "1"))
                .andExpect(status().isOk());

        verify(service).deleteUserById(1L);
    }
}
