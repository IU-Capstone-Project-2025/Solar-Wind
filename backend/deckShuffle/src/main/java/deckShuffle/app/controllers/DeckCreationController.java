package deckShuffle.app.controllers;

import com.solarwind.dto.UserDto;
import deckShuffle.app.services.DeckCreationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class DeckCreationController {
    @Autowired
    private DeckCreationService service;

    @GetMapping("/create-deck")
    public List<UserDto> createDeck(@RequestParam Long id) {
        return service.createDeck(id);
    }
}
