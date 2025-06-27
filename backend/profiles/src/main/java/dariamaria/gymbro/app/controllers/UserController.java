package dariamaria.gymbro.app.controllers;

import com.solarwind.dto.UserDto;
import dariamaria.gymbro.app.services.UserManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/api")
public class UserController {
    @Autowired
    private UserManagementService service;
    @PostMapping("/me")
    public Map<String, Long> createUser(@RequestBody UserDto dto) {
        Map<String, Long> response = new HashMap<>();
        response.put("id", service.createUser(dto));
        return response;
    }
    @GetMapping("/hello")
    public String hello() {
        return "Hello Solar Wind!";
    }
    @GetMapping("/me")
    public UserDto getUserById(@RequestParam long id) {
        return service.getByUserId(id);
    }
    @GetMapping("/getUsers")
    public List<UserDto> getUsers() {
        return service.getUsers();
    }
    @DeleteMapping("/deleteUserById")
    public void deleteUser(@RequestParam long id) {
        service.deleteUserById(id);
    }
}
