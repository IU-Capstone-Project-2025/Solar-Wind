package com.solarwind.component;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;
import com.solarwind.repositories.CityRepository;
import com.solarwind.repositories.SportRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class MapperHelper {
    @Autowired
    private SportRepository sportRepository;

    @Autowired
    private CityRepository cityRepository;

    public MapperHelper(SportRepository sportRepository) {
        this.sportRepository = sportRepository;
    }

    public CityEntity fromId(Long id) {
        return id == null ? null : cityRepository.findById(id).orElse(null);
    }

    public Long toId(CityEntity city) {
        return city != null ? city.getId() : null;
    }

    public List<Long> mapSportsToIds(List<SportEntity> sports) {
        if (sports == null) return null;
        return sports.stream().map(SportEntity::getId).toList();
    }

    public List<SportEntity> mapIdsToSports(List<Long> ids) {
        if (ids == null) return null;
        return sportRepository.findAllById(ids);
    }
}