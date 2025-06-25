package likes.app.services.implementations;

import com.solarwind.dto.LikesDto;
import com.solarwind.mappers.LikesMapper;
import com.solarwind.models.LikesCompositePrimaryKey;
import com.solarwind.models.LikesEntity;
import com.solarwind.repositories.LikesRepository;
import likes.app.infrastructure.notifier.MatchNotificationPort;
import likes.app.services.LikesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class LikesServiceImp implements LikesService {
    @Autowired
    private LikesRepository repository;
    @Autowired
    private LikesMapper mapper;
    private MatchNotificationPort matchNotificationPort;

    public LikesServiceImp(@Qualifier("httpNotifier") MatchNotificationPort matchNotificationPort) {
        this.matchNotificationPort = matchNotificationPort;
    }

    // TODO: fix SRP violation
    public void saveOrUpdateDecision(LikesDto dto) {
        LikesEntity exampleReverse = new LikesEntity();
        exampleReverse.setId(new LikesCompositePrimaryKey(dto.getLikedId() , dto.getLikerId()));
        Optional<LikesEntity> decisionReverse = repository.findOne(Example.of(exampleReverse));

        LikesEntity exampleStraight = new LikesEntity();
        exampleStraight.setId(new LikesCompositePrimaryKey(dto.getLikerId(), dto.getLikedId()));
        Optional<LikesEntity> decisionStraight = repository.findOne(Example.of(exampleStraight));

        LikesEntity decisionEntity;

        if (decisionStraight.isPresent()) {
            decisionEntity = decisionStraight.get();
        } else if (decisionReverse.isPresent()) {
            decisionEntity = decisionReverse.get();
        } else {
            LikesEntity entity = mapper.mapToLikesEntity(dto);
            repository.save(entity);
            repository.flush();
            return;
        }
        if (decisionEntity.getIsSecondLikes() != null) {
            decisionEntity.setIsFirstLikes(dto.getIsFirstLikes());
        } else {
            decisionEntity.setIsSecondLikes(dto.getIsFirstLikes());
        }
        repository.save(decisionEntity);
        repository.flush();

        if (decisionEntity.getIsFirstLikes() && decisionEntity.getIsSecondLikes()) {
            matchNotificationPort.notifyMatch(dto.getLikerId(), dto.getLikedId());
        }
    }
}
