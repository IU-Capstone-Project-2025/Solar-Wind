package deckShuffle.app.services.implementation;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.UserMapper;
import com.solarwind.repositories.UserRepository;
import deckShuffle.app.services.DeckCreationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class DeckCreationServiceImp implements DeckCreationService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private DeckCacheableService deckCacheableService;
    @Autowired
    private UserMapper userMapper;

    @Override
    public List<ProfileDto> createDeck(Long user_id) {
        UserDto initialUser = userMapper.mapToUsersDto(userRepository.findById(user_id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found")));
        return deckCacheableService.getOrCreateDeck(initialUser);
    }
}
