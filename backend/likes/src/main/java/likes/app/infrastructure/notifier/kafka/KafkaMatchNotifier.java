package likes.app.infrastructure.notifier.kafka;

import likes.app.infrastructure.notifier.MatchNotificationPort;

public class KafkaMatchNotifier implements MatchNotificationPort {
    @Override
    public void notifyMatch(Long likerId, Long likedId) {
        // todo
    }
}
