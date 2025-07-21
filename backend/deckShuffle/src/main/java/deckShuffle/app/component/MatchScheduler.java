package deckShuffle.app.component;

import deckShuffle.app.services.implementation.DeckCacheableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class MatchScheduler {
    @Autowired
    private DeckCacheableService generatorService;

    @Scheduled(cron = "0 0 2 * * *")
    public void scheduleMatchGeneration() {
        generatorService.generateMatches();
    }
}

