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

    @Named("fromId")
    public CityEntity fromId(Long id) {
        return id == null ? null : cityRepository.findById(id).orElse(null);
    }

    @Named("toId")
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
        List<Integer> result = new ArrayList<>();
        if (bitmask == null) return result;
        for (int i = 0; i < 32; i++) {
            if ((bitmask & (1 << i)) != 0) {
                result.add(i);
            }
        }
        return result;
    }

    @Named("mapGymTimeToBits")
    public Integer mapGymTimeToBits(List<Integer> times) {
        if (times == null) return 0;
        int mask = 0;
        for (Integer time : times) {
            if (time != null && time >= 0 && time < 32) {
                mask |= (1 << time);
            }
        }
        return mask;
    }
}
