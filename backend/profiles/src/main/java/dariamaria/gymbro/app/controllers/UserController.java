package dariamaria.gymbro.app.controllers;

import com.solarwind.dto.UserDto;
import dariamaria.gymbro.app.services.UserManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
public class UserController {
    @Autowired
    private UserManagementService service;
    @PostMapping("/createUser")
    public Long createUser(@RequestBody UserDto dto) {
        return service.createUser(dto);
    }
    @GetMapping("/hello")
    public String hello() {
        return "Hello Solar Wind!";
    }
    @GetMapping("/getUserById")
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
