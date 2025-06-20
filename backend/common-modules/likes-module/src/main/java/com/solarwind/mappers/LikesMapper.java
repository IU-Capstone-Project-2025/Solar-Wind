package com.solarwind.mappers;

import com.solarwind.dto.LikesDto;
import com.solarwind.models.LikesEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface LikesMapper {
    LikesDto mapToLikesDto(LikesEntity user);
    LikesEntity mapToLikesEntity(LikesDto dto);
}