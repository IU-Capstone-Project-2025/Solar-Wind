package dariamaria.gymbro.app.services.implementation;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dariamaria.gymbro.app.services.CityService;
import jakarta.annotation.Resource;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Service
public class CityServiceImp implements CityService {
    private final List<String> cities;

    public CityServiceImp(ObjectMapper mapper) throws IOException {
        // 1) Находим ресурс в classpath
        ClassPathResource resource = new ClassPathResource("json/cities-names.json");
        // 2) Открываем InputStream
        try (InputStream is = resource.getInputStream()) {
            // 3) Читаем JSON-массив в List<String>
            this.cities = mapper.readValue(is, new TypeReference<>() {
            });
        }
    }

    public List<String> getAllCities() {
        return cities;
    }

}
