package likes.app.infrastructure.notifier.http;

import likes.app.infrastructure.notifier.MatchNotificationPort;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

@Service
@Qualifier("httpNotifier")
public class HttpMatchNotifier implements MatchNotificationPort {
    private final RestTemplate restTemplate;
    private final String matchServiceUrl;

    public HttpMatchNotifier(@Value("${spring.match-service.url}") String matchServiceUrl) {
        this.restTemplate = new RestTemplate();
        this.matchServiceUrl = matchServiceUrl;
    }

    @Override
    public void notifyMatch(Long likerId, Long likedId) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.TEXT_PLAIN);

        String fullUrl = UriComponentsBuilder.fromUriString(matchServiceUrl + "/")
                .queryParam("user1", likedId)
                .queryParam("user2", likerId)
                .build()
                .toUriString();

        restTemplate.postForEntity(fullUrl, new HttpEntity<>(headers), Void.class);
    }
}
