package com.solarwind.component;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;
import com.solarwind.repositories.CityRepository;
import com.solarwind.repositories.SportRepository;
import org.mapstruct.Named;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
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

    @Named("mapGymTimeFromBits")
    public List<Integer> mapGymTimeFromBits(Integer bitmask) {
        if (bitmask == null) return new ArrayList<>();
        List<Integer> days = new ArrayList<>();
        for (int i = 0; i < 7; i++) {
            if ((bitmask & (1 << i)) != 0) {
                days.add(i);
            }
        }
        return days;
    }

    @Named("mapGymTimeToBits")
    public Integer mapGymTimeToBits(List<Integer> days) {
        if (days == null) return 0;
        int bitmask = 0;
        for (Integer day : days) {
            bitmask |= (1 << day);
        }
        return bitmask;
    }
}