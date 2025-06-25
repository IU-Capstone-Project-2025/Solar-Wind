package deckShuffle.app.services;

import com.solarwind.dto.UserDto;

import java.util.List;

public interface DeckCreationService {
    public List<Long> createDeck(Long user_id);
}
