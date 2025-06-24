package notifications.app.controllers;

import notifications.app.dto.NotificationDto;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;

/*
* This is a temporary solution for the notification of the client, that should be implemented
* by the client side by the hands of the developer. Client device should poll the get endpoint with
* the user id to obtain current unseen notifications.
*
* Server-side should post on the root endpoint to add in the system new, unseen event
* */
@RestController
public class DispatcherController {
    private final static HashMap<Long, ArrayList<NotificationDto>> allNotifications = new HashMap<>();

    @GetMapping("/")
    public ArrayList<NotificationDto> dispatcher(@RequestHeader Long owner) {
        var result = allNotifications.get(owner);
        allNotifications.remove(owner);
        return result;
    }

    @PostMapping("/")
    public void publish(@RequestParam Long user1, @RequestParam Long user2) {
        if (!allNotifications.containsKey(user1)) {
            allNotifications.put(user1, new ArrayList<>());
        }
        allNotifications.get(user1).add(new NotificationDto("You have the match!", user1, user2));
    }
}
