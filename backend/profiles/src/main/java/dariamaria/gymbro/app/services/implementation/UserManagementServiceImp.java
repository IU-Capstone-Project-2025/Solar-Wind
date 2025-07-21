package dariamaria.gymbro.app.services.implementation;

import com.solarwind.models.PhotoEntity;
import com.solarwind.repository.PhotoRepository;
import com.solarwind.component.MapperHelper;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.UserMapper;
import com.solarwind.models.UserEntity;
import com.solarwind.repositories.CityRepository;
import com.solarwind.repositories.SportRepository;
import com.solarwind.services.implementations.UserRetrievalServiceImp;
import dariamaria.gymbro.app.services.UserManagementService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UserManagementServiceImp extends UserRetrievalServiceImp implements UserManagementService {
    @Autowired
    private CityRepository cityRepository;
    @Autowired
    private PhotoRepository photoRepository;
    @Autowired
    private MapperHelper helper;

    @Override
    public Long createUser(UserDto dto) {
        UserEntity user = userMapper.mapToUsersEntity(dto);
        repository.save(user);
        return repository.findIdByUsername(user.getUsername());
    }

    @Override
    public void deleteUserById(long id) {
        repository.deleteById(id);
    }

    @Override
    public void update(UserDto dto) {
        UserEntity user = repository.findById(dto.getId())
                .orElseThrow(() -> new EntityNotFoundException("User not found with id: " + dto.getId()));

        if (dto.getUsername() != null && !dto.getUsername().isBlank()) {
            user.setUsername(dto.getUsername());
        }

        if (dto.getDescription() != null && !dto.getDescription().isBlank()) {
            user.setDescription(dto.getDescription());
        }

        if (dto.getAge() != null) {
            user.setAge(dto.getAge());
        }

        if (dto.getGender() != null) {
            user.setGender(dto.getGender());
        }

        if (dto.getVerified() != null) {
            user.setVerified(dto.getVerified());
        }

        if (dto.getPreferredGender() != null) {
            user.setPreferredGender(dto.getPreferredGender());
        }

        if (dto.getCityId() != null) {
            System.out.println(cityRepository.findById(dto.getCityId()));
            user.setCity(cityRepository.findById(dto.getCityId())
                    .orElseThrow(() -> new EntityNotFoundException("City not found with id: " + dto.getCityId())));
        }

        if (dto.getPreferredGymTime() != null && !dto.getPreferredGymTime().isEmpty()) {
            user.setPreferredGymTime(helper.mapGymTimeToBits(dto.getPreferredGymTime()));
        }

        if (dto.getSportId() != null && !dto.getSportId().isEmpty()) {
            user.setSports(helper.mapIdsToSports(dto.getSportId()));
        }
        System.out.println(user);

        repository.save(user);
    }

    @Override
    public void savePhoto(Long id, byte[] photo) {
        PhotoEntity entity = new PhotoEntity();
        entity.setImage(photo);
        photoRepository.save(entity);
        Optional<PhotoEntity> optional = photoRepository.findByImage(photo);
        Long photoId = optional.map(PhotoEntity::getId)
                .orElseThrow(() -> new EntityNotFoundException("Photo not found"));
        UserEntity user = repository.getReferenceById(id);
        user.setPhotoId(photoId);
        repository.save(user);
    }
}
