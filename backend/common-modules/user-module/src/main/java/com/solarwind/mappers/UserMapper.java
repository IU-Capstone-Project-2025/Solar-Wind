package com.solarwind.mappers;

import com.solarwind.component.MapperHelper;
import com.solarwind.dto.UserDto;
import com.solarwind.models.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;


@Mapper(componentModel = "spring", uses = MapperHelper.class)
public interface UserMapper {
    @Mapping(target = "sportId", source = "sports")
    @Mapping(target = "cityId", source = "city")
    UserDto mapToUsersDto(UserEntity user);
    @Mapping(target = "sports", source = "sportId")
    @Mapping(target = "city", source = "cityId")
    UserEntity mapToUsersEntity(UserDto dto);
}