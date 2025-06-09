package dariamaria.gymbro.app.controllers;

import dariamaria.gymbro.app.dto.UsersDto;
import dariamaria.gymbro.app.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class UserController {
    @Autowired
    private UserService service;
    @PostMapping("/createUser")
    public UsersDto createUser(@RequestBody UsersDto dto) {
        return service.createUser(dto);
    }
    @GetMapping("/")
    public String hello() {
        return "Hello Дарияяяяяяяя!";
    }
    @GetMapping("/getUserById")
    public UsersDto getUserById(@RequestParam long id) {
        return service.getByUserId(id);
    }
    @GetMapping("/getUsers")
    public List<UsersDto> getUsers() {
        return service.getUsers();
    }
    @DeleteMapping("/deleteUserById")
    public void deleteUser(@RequestParam long id) {
        service.deleteUserById(id);
    }
}
