package deckShuffle.app.controllers;

import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class AliveController {
    @GetMapping("/")
    public String hello() {
        return "hi from deckShuffle.app";
    }
    @GetMapping("/ping")
    public String ping() {
        return "pong";
    }
}
