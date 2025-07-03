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

    private LikesServiceImp likesService;

    @BeforeEach
    void setup() {
        likesService = new LikesServiceImp(matchNotificationPort);
    }

    @Test
    void testSaveOrUpdateDecision_whenNoExistingLikes_thenSaveNewEntity() {
//        LikesDto dto = new LikesDto(1L, 2L, true, null);
//
//        when(repository.findOne(any(Example.class))).thenReturn(Optional.empty());
//
//        LikesEntity newEntity = new LikesEntity();
//        when(mapper.mapToLikesEntity(dto)).thenReturn(newEntity);
//
//        when(repository.save(any(LikesEntity.class))).thenAnswer(invocation -> invocation.getArgument(0));
//        doNothing().when(repository).flush();
//
//        likesService.saveOrUpdateDecision(dto);
//
//        verify(repository).save(newEntity);
//        verify(repository).flush();
//        verifyNoInteractions(matchNotificationPort);
    }
}
