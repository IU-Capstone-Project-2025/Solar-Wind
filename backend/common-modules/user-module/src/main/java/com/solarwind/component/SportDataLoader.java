package com.solarwind.component;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.solarwind.models.SportEntity;
import com.solarwind.repositories.SportRepository;
import org.springframework.stereotype.Component;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.ApplicationArguments;

import java.io.InputStream;
import java.util.List;


@Component
public class SportDataLoader implements ApplicationRunner {

    private final SportRepository repository;
    private final ObjectMapper objectMapper;

    public SportDataLoader(SportRepository repository, ObjectMapper objectMapper) {
        this.repository = repository;
        this.objectMapper = objectMapper;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        if (repository.count() > 0) {
            return;
        }
        InputStream inputStream = getClass().getResourceAsStream("/json/sports.json");

        List<String> sportNames = objectMapper.readValue(
                inputStream,
                new TypeReference<>() {}
        );

        List<SportEntity> sports = sportNames.stream()
                .map(name -> {
                    SportEntity sport = new SportEntity();
                    sport.setSportType(name);
                    return sport;
                })
                .toList();

        repository.deleteAllInBatch();
        repository.saveAll(sports);

    }
}
