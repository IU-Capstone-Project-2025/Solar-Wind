package dariamaria.gymbro.app.services;

import com.solarwind.models.CityEntity;

import java.util.List;

public interface CityManagementService {
    public List<CityEntity> getCities();
    public List<CityEntity> getPartOfCities(int page, int size);

    List<CityEntity> searchCity(String word);
}
