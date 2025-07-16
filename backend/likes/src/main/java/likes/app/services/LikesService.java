package likes.app.services;

import com.solarwind.dto.LikesDto;
import org.springframework.stereotype.Service;

@Service
public interface LikesService {
    void saveOrUpdateDecision(LikesDto dto);
}
