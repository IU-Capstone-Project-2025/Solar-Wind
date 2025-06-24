package likes.app.services.implementations;

import com.solarwind.dto.LikesDto;
import com.solarwind.mappers.LikesMapper;
import com.solarwind.models.LikesCompositePrimaryKey;
import com.solarwind.models.LikesEntity;
import com.solarwind.repositories.LikesRepository;
import likes.app.infrastructure.notifier.MatchNotificationPort;
import likes.app.infrastructure.notifier.http.HttpMatchNotifier;
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
        LikesEntity example = new LikesEntity();
        example.setId(new LikesCompositePrimaryKey(dto.getLikerId(), dto.getLikedId()));
        Optional<LikesEntity> decision = repository.findOne(Example.of(example));
        if (decision.isEmpty()) {
            LikesEntity entity = mapper.mapToLikesEntity(dto);
            repository.save(entity);
            repository.flush();
            return;
        }
        LikesEntity decisionEntity = decision.get();
        if (dto.getIsFirstLikes() != null) {
            decisionEntity.setIsFirstLikes(dto.getIsFirstLikes());
        } else {
            decisionEntity.setIsSecondLikes(dto.getIsSecondLikes());
        }
        repository.save(decisionEntity);
        repository.flush();

        if (decisionEntity.getIsFirstLikes() && decisionEntity.getIsSecondLikes()) {
            matchNotificationPort.notifyMatch(dto.getLikerId(), dto.getLikedId());
        }
    }
}
