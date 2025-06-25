package likes.app.controllers;

import com.solarwind.dto.LikesDto;
import likes.app.services.LikesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
public class MatchController {
    @Autowired
    LikesService likesService;
    @PostMapping("/")
    public void match(@RequestParam Long receiver, @RequestHeader("Authorization-telegram-id") Long sender) {
        likesService.saveOrUpdateDecision(new LikesDto(sender, receiver, true, null));
    }
}
