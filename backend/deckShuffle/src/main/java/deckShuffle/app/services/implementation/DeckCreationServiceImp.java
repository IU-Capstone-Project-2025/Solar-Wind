package deckShuffle.app.services.implementation;

import com.solarwind.component.MapperHelper;
import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.ProfileMapper;
import com.solarwind.mappers.UserMapper;
import com.solarwind.models.UserEntity;
import com.solarwind.repositories.UserRepository;
import com.solarwind.repositories.specifications.UserSpecifications;
import deckShuffle.app.services.DeckCreationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
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
    @Autowired
    private ProfileMapper profileMapper;

    @Override
    public List<ProfileDto> createDeck(Long user_id) {
        UserDto initialUser = userMapper.mapToUsersDto(userRepository.findById(user_id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found")));
        return deckCacheableService.getOrCreateDeck(initialUser);
    }

    @Override
    @Transactional
    public List<ProfileDto> createDeckByFilter(UserDto dto) {
        Specification<UserEntity> spec = Specification.where(null);

        if (dto.getCityId() != null) {
            spec = spec.and(UserSpecifications.hasCity(dto.getCityId()));
        }

        if (dto.getGender() != null) {
            spec = spec.and(UserSpecifications.hasGender(dto.getGender()));
        }

        if (dto.getPreferredGender() != null) {
            spec = spec.and(UserSpecifications.hasPreferredGender(dto.getPreferredGender()));
        }

        if (dto.getAge() != null) {
            spec = spec.and(UserSpecifications.hasAge(dto.getAge()));
        }

        if (dto.getPreferredGymTime() != null && !dto.getPreferredGymTime().isEmpty()) {
            spec = spec.and(UserSpecifications.hasPreferredGymTimeIn(dto.getPreferredGymTime()));
        }

        if (dto.getSportId() != null && !dto.getSportId().isEmpty()) {
            spec = spec.and(UserSpecifications.hasAnySportId(dto.getSportId()));
        }

        if (dto.getId() != null) {
            spec = spec.and(UserSpecifications.excludeUserId(dto.getId()));
        }

        return userRepository.findAll(spec).stream()
                .map(profileMapper::mapToProfileDto)
                .toList();
    }

}
