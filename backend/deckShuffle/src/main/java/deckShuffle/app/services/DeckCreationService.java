package deckShuffle.app.services;

import com.solarwind.dto.UserDto;

import java.util.List;

public interface DeckCreationService {
    public List<UserDto> createDeck(Long user_id);
}
