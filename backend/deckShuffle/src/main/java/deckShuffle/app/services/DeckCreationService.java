package deckShuffle.app.services;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;

import java.util.List;

public interface DeckCreationService {
    public List<ProfileDto> createDeck(Long user_id);
}
