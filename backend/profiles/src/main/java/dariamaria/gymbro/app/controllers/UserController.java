package dariamaria.gymbro.app.controllers;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.DatabaseSourceReader;
import dariamaria.gymbro.app.services.UserManagementService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Secured(DatabaseSourceReader.class)
@RestController
@RequestMapping("/api")
public class UserController {
    @Autowired
    private UserManagementService service;

    @PostMapping("/me")
    public Map<String, Long> createUser(@Valid @RequestBody UserDto dto) {
        Map<String, Long> response = new HashMap<>();
        response.put("id", service.createUser(dto));
        return response;
    }

    @GetMapping("/me")
    public ProfileDto getUserById(@RequestHeader("Authorization-telegram-id") long id) {
        return service.getByUserId(id);
    }

    @DeleteMapping("/me")
    public void deleteUser(@RequestHeader("Authorization-telegram-id") long id) {
        service.deleteUserById(id);
    }

    @PutMapping("/me")
    public void updateUser(@Valid @RequestBody UserDto dto) {
        service.update(dto);
    }

    @GetMapping("/getUsers")
    public List<ProfileDto> getUsers() {
        return service.getUsers();
    }
}
