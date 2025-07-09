package deckShuffle.app.controllers;

import com.solarwind.dto.ProfileDto;
import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.DatabaseSourceReader;
import deckShuffle.app.services.DeckCreationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Secured(DatabaseSourceReader.class)
@RestController
@RequestMapping("/api")
public class DeckCreationController {
    @Autowired
    private DeckCreationService service;

    @GetMapping("/create-deck")
    public List<ProfileDto> createDeck(@RequestHeader("Authorization-telegram-id") Long id) {
        return service.createDeck(id);
    }
}
