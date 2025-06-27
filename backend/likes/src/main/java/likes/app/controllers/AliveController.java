package likes.app.controllers;

import org.springframework.web.bind.annotation.*;

@RestController
public class AliveController {
    @GetMapping("/")
    public String hello() {
        return "hi from likes.app";
    }
    @GetMapping("/ping")
    public String ping() {
        return "pong";
    }
}
