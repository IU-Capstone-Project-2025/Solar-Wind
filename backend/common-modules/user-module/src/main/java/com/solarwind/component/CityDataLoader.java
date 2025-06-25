package com.solarwind.component;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.solarwind.models.CityEntity;
import com.solarwind.repositories.CityRepository;
import org.springframework.stereotype.Component;
import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.ApplicationArguments;

import java.io.InputStream;
import java.util.List;

@Component
public class CityDataLoader implements ApplicationRunner {

    private final CityRepository cityRepository;
    private final ObjectMapper objectMapper;

    public CityDataLoader(CityRepository cityRepository, ObjectMapper objectMapper) {
        this.cityRepository = cityRepository;
        this.objectMapper = objectMapper;
    }

    @Override
    public void run(ApplicationArguments args) throws Exception {
        if (cityRepository.count() > 0) {
            return;
        }
        InputStream inputStream = getClass().getResourceAsStream("/json/cities-names.json");

        List<String> cityNames = objectMapper.readValue(
                inputStream,
                new TypeReference<>() {}
        );

        List<CityEntity> cities = cityNames.stream()
                .map(name -> {
                    CityEntity city = new CityEntity();
                    city.setCityName(name);
                    return city;
                })
                .toList();

        cityRepository.deleteAllInBatch();
        cityRepository.saveAll(cities);

    }
}
