package dariamaria.gymbro.app.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AliveController {
    @GetMapping("/ping")
    public String hello() {
        return "pong";
    }
}
