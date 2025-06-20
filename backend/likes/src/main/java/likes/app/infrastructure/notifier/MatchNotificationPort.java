package likes.app.infrastructure.notifier;

public interface MatchNotificationPort {
    void notifyMatch(Long likerId, Long likedId);
}
