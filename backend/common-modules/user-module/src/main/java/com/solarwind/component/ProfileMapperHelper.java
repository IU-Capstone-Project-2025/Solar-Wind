package com.solarwind.component;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;
import com.solarwind.repositories.CityRepository;
import com.solarwind.repositories.SportRepository;
import lombok.NoArgsConstructor;
import org.mapstruct.Named;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@NoArgsConstructor
public class ProfileMapperHelper {
    @Autowired
    private CityRepository cityRepository;

    @Named("fromId")
    public String fromId(Long id) {
        return id == null ? null : cityRepository.findById(id).orElse(null).getCityName();
    }

    @Named("mapSportsToName")
    public List<String> mapSportsToName(List<SportEntity> sports) {
        if (sports == null) return null;
        return sports.stream().map(SportEntity::getSportType).toList();
    }

    @Named("mapCityToName")
    public String mapCityToName(CityEntity city) {
        return city == null ? null : city.getCityName();
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
}
