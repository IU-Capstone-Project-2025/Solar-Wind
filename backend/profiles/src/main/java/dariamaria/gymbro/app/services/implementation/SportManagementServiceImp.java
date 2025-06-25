package dariamaria.gymbro.app.services.implementation;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;
import com.solarwind.repositories.SportRepository;
import dariamaria.gymbro.app.services.SportManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SportManagementServiceImp implements SportManagementService {
    @Autowired
    private SportRepository sportRepository;

    @Override
    public List<SportEntity> getSports() {
        return sportRepository.findAll();
    }

    @Override
    public List<SportEntity> getPartOfCities(int page, int size) {
        return sportRepository.findAll().subList(page*size, (page+1)*size);
    }

    @Override
    public List<SportEntity> searchCity(String word) {
        return sportRepository.findByWord(word);
    }
}