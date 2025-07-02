package likes.app.services;

import static org.mockito.Mockito.*;
import static org.junit.jupiter.api.Assertions.*;

import com.solarwind.dto.LikesDto;
import com.solarwind.models.LikesCompositePrimaryKey;
import com.solarwind.models.LikesEntity;
import com.solarwind.repositories.LikesRepository;
import likes.app.infrastructure.notifier.MatchNotificationPort;
import likes.app.services.implementations.LikesServiceImp;
import com.solarwind.mappers.LikesMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.*;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.data.domain.Example;

import java.util.Optional;

@ExtendWith(MockitoExtension.class)
public class LikesServiceTest {
    @Mock
    private LikesRepository repository;
    @Mock
    private LikesMapper mapper;
    @Mock
    private MatchNotificationPort matchNotificationPort;

    @InjectMocks
    private LikesServiceImp likesService;

    @Test
    public void shouldSaveNewLikeWhenNoDecisionFound() {
        LikesDto dto = new LikesDto();
        dto.setLikerId(1L);
        dto.setLikedId(2L);
        dto.setIsFirstLikes(true);

        when(repository.findOne(any(Example.class))).thenReturn(Optional.empty());
        when(mapper.mapToLikesEntity(dto)).thenReturn(new LikesEntity());

        likesService.saveOrUpdateDecision(dto);

        verify(repository).save(any(LikesEntity.class));
        verify(repository).flush();
        verifyNoInteractions(matchNotificationPort);
    }

    @Test
    public void shouldUpdateExistingDecisionAndNotifyMatchWhenBothLikes() {
        LikesDto dto = new LikesDto();
        dto.setLikerId(1L);
        dto.setLikedId(2L);
        dto.setIsFirstLikes(true);

        LikesEntity existingEntity = new LikesEntity();
        existingEntity.setId(new LikesCompositePrimaryKey(1L, 2L));
        existingEntity.setIsSecondLikes(true);
        existingEntity.setIsFirstLikes(false);

        when(repository.findOne(any(Example.class)))
                .thenReturn(Optional.empty())
                .thenReturn(Optional.of(existingEntity));

        likesService.saveOrUpdateDecision(dto);

        assertTrue(existingEntity.getIsFirstLikes());
        verify(repository).save(existingEntity);
        verify(repository).flush();
        verify(matchNotificationPort).notifyMatch(dto.getLikerId(), dto.getLikedId());
    }

    @Test
    public void shouldUpdateExistingDecisionWhenIsSecondLikesIsNull() {
        LikesDto dto = new LikesDto();
        dto.setLikerId(1L);
        dto.setLikedId(2L);
        dto.setIsFirstLikes(false);

        LikesEntity existingEntity = new LikesEntity();
        existingEntity.setId(new LikesCompositePrimaryKey(1L, 2L));
        existingEntity.setIsSecondLikes(null);
        existingEntity.setIsFirstLikes(true);

        when(repository.findOne(any(Example.class))).thenReturn(Optional.of(existingEntity));

        likesService.saveOrUpdateDecision(dto);

        assertEquals(dto.getIsFirstLikes(), existingEntity.getIsSecondLikes());
        assertTrue(existingEntity.getIsFirstLikes());

        verify(repository).save(existingEntity);
        verify(repository).flush();
        verifyNoInteractions(matchNotificationPort);
    }
}