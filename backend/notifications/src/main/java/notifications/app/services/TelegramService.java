package notifications.app.services;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class TelegramService {

    @Value("${telegram.bot.token}")
    private String botToken;

    private final RestTemplate restTemplate = new RestTemplate();

    public void sendTelegramMessage(Long chatId, String message) {
        String url = String.format(
                "https://api.telegram.org/bot%s/sendMessage?chat_id=%d&text=%s",
                botToken, chatId, message.replace(" ", "%20")
        );
        restTemplate.postForObject(url, null, String.class);
    }
}
