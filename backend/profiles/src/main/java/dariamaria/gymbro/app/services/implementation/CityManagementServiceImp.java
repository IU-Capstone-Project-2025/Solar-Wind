package dariamaria.gymbro.app.services.implementation;

import com.solarwind.models.CityEntity;
import com.solarwind.repositories.CityRepository;
import dariamaria.gymbro.app.services.CityManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CityManagementServiceImp implements CityManagementService {
    @Autowired
    private CityRepository cityRepository;
    @Override
    public List<CityEntity> getCities() {
        return cityRepository.findAll();
    }

    @Override
    public List<CityEntity> getPartOfCities(int page, int size) {
        return cityRepository.findAll().subList(page*size, (page+1)*size);
    }

    @Override
    public List<CityEntity> searchCity(String word) {
        return cityRepository.findByWord(word);
    }
}