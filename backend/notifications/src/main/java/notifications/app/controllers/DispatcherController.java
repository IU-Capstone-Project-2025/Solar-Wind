package notifications.app.controllers;

import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.DatabaseSourceReader;
import com.solarwind.securityModule.service.PropertyTokenSourceReader;
import notifications.app.dto.NotificationDto;
import notifications.app.services.TelegramService;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private TelegramService telegramService;

    @Secured(DatabaseSourceReader.class)
    @GetMapping("/")
    public ArrayList<NotificationDto> dispatcher(@RequestHeader("Authorization-telegram-id") Long owner) {
        var result = allNotifications.get(owner);
        allNotifications.remove(owner);
        return result;
    }

    @Secured(PropertyTokenSourceReader.class)
    @PostMapping("/")
    public void publish(@RequestParam Long user1, @RequestParam Long user2) {
        for (var userPair : new Long[][]{{user1, user2}, {user2, user1}}) {
            var user = userPair[0];
            if (!allNotifications.containsKey(user)) {
                allNotifications.put(user, new ArrayList<>());
            }
            NotificationDto notification = new NotificationDto("You have the match! ", user1, user2);
            allNotifications.get(user).add(notification);
            telegramService.sendTelegramMessage(user,
                    notification.Text() + "https://web.telegram.org/a/#" + userPair[1]);
        }
    }
}
