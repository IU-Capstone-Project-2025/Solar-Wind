package deckShuffle.app.controllers;

import com.solarwind.dto.ProfileDto;
import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.DatabaseSourceReader;
import com.solarwind.dto.UserDto;
import deckShuffle.app.services.DeckCreationService;
import deckShuffle.app.services.implementation.DeckCacheableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Secured(DatabaseSourceReader.class)
@RestController
@RequestMapping("/api")
public class DeckCreationController {
    @Autowired
    private DeckCreationService service;
    @Autowired
    private DeckCacheableService savedDeck;

    @GetMapping("/create-deck")
    public List<ProfileDto> createDeck(@RequestHeader("Authorization-telegram-id") Long id) {
        return service.createDeck(id);
    }
    @GetMapping("/filter")
    public List<ProfileDto> createDeckByFilter(@RequestBody UserDto filterDto) {
        return service.createDeckByFilter(filterDto);
    }
    @GetMapping("/create-saved-deck")
    public void saveDeck() {
        savedDeck.generateMatches();
    }
}
