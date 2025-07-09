package deckShuffle.app.services.implementation;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.ProfileMapper;
import com.solarwind.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeckCacheableService {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProfileMapper profileMapper;

    @Cacheable(value = "user-deck", key = "#initialUser")
    public List<ProfileDto> getOrCreateDeck(UserDto initialUser){
        System.out.println(initialUser);
        return userRepository.createDeckAllSettings(
                        initialUser.getGender().toString(),
                        initialUser.getPreferredGender().toString(),
                        initialUser.getCityId(),
                        initialUser.getAge(),
                        initialUser.getId()
                ).stream()
                .map(profileMapper::mapToProfileDto)
                .toList();
    }
}
