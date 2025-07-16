package dariamaria.gymbro.app.services;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;

import java.util.List;

public interface SportManagementService {
    public List<SportEntity> getSports();

    List<SportEntity> getPartOfSports(int page, int size);

    List<SportEntity> searchSport(String word);
}
