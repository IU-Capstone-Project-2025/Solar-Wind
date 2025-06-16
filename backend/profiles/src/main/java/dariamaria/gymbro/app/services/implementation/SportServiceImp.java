package dariamaria.gymbro.app.services.implementation;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import dariamaria.gymbro.app.services.SportService;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

@Service
public class SportServiceImp implements SportService {
    private final List<String> sports;

    public SportServiceImp(ObjectMapper mapper) throws IOException {
        ClassPathResource resource = new ClassPathResource("json/sports.json");
        try (InputStream is = resource.getInputStream()) {
            this.sports = mapper.readValue(is, new TypeReference<>() {
            });
        }
    }

    public List<String> getAllSports() {
        return sports;
    }
}
