package com.solarwind.mappers;

import com.solarwind.component.MapperHelper;
import com.solarwind.component.ProfileMapperHelper;
import com.solarwind.dto.ProfileDto;
import com.solarwind.models.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring", uses = ProfileMapperHelper.class)
public interface ProfileMapper {
    @Mapping(target = "sportName", source = "sports", qualifiedByName = "mapSportsToName")
    @Mapping(target = "cityName", source = "city", qualifiedByName = "mapCityToName")
    @Mapping(target = "preferredGymTime", source = "preferredGymTime", qualifiedByName = "mapGymTimeFromBits")
    ProfileDto mapToProfileDto(UserEntity user);
}

