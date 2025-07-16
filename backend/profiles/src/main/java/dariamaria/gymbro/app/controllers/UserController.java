package dariamaria.gymbro.app.controllers;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.DatabaseSourceReader;
import dariamaria.gymbro.app.services.UserManagementService;
import jakarta.persistence.EntityNotFoundException;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

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
        try {
            return service.getByUserId(id);
        } catch (EntityNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }

    @PostMapping("/save-photo")
    public void savePhoto(@RequestHeader("Authorization-telegram-id") long id, @RequestParam byte[] photo) {
        try {
            service.savePhoto(id, photo);
        } catch (EntityNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
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
