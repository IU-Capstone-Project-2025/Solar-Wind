package likes.app.controllers;

import com.solarwind.dto.LikesDto;
import likes.app.services.LikesService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MatchController {
    @Autowired
    LikesService likesService;
    @PostMapping("/")
    public void match(@RequestAttribute Long receiver, @RequestHeader("Authorization-telegram-id") Long sender) {
        likesService.saveOrUpdateDecision(new LikesDto(sender, receiver, true, null));
    }
}
