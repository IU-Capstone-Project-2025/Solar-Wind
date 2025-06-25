package deckShuffle.app.services.implementation;

import com.solarwind.dto.UserDto;
import com.solarwind.mappers.UserMapper;
import com.solarwind.repositories.UserRepository;
import deckShuffle.app.services.DeckCreationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class DeckCreationServiceImp implements DeckCreationService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private UserMapper mapper;

    @Override
    public List<UserDto> createDeck(Long user_id) {
        UserDto initialUser = mapper.mapToUsersDto(userRepository.findById(user_id)
                .orElseThrow(() -> new RuntimeException("User not found")));

        return userRepository.createDeckAllSettings(initialUser.getGender().toString(),
                initialUser.getPreferredGender().toString(),
                initialUser.getCityId(), initialUser.getAge(), initialUser.getId()).stream().map(user ->
                mapper.mapToUsersDto(user)).toList();
    }

    //Процент схожести интересов
    private double jaccard_similarity(Set<String> set1, Set<String>set2) {
        Set<String> intersection = new HashSet<>(set1);
        intersection.retainAll(set2);
        Set<String> union = new HashSet<>(set1);
        union.addAll(set2);
        if (union.isEmpty()) {
            return 0.0;
        }
        return (double) (100 * intersection.size() / union.size());
    }

}
