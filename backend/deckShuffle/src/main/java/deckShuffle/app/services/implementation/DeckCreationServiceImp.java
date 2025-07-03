package deckShuffle.app.services.implementation;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.ProfileMapper;
import com.solarwind.mappers.UserMapper;
import com.solarwind.repositories.UserRepository;
import deckShuffle.app.services.DeckCreationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DeckCreationServiceImp implements DeckCreationService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private ProfileMapper profileMapper;
    @Autowired
    private UserMapper userMapper;

    @Override
    public List<ProfileDto> createDeck(Long user_id) {
        UserDto initialUser = userMapper.mapToUsersDto(userRepository.findById(user_id)
                .orElseThrow(() -> new RuntimeException("User not found")));
        System.out.println(initialUser);
        return userRepository.createDeckAllSettings(initialUser.getGender().toString(),
                initialUser.getPreferredGender().toString(),
                initialUser.getCityId(), initialUser.getAge(), initialUser.getId()).stream().map(user ->
                profileMapper.mapToProfileDto(user)).toList();
    }
}
