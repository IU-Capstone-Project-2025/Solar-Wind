package com.solarwind.mappers;

import com.solarwind.dto.LikesDto;
import com.solarwind.models.LikesEntity;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface LikesMapper {
    @Mapping(source = "id.likerIdFirst", target = "likerId")
    @Mapping(source = "id.likerIdSecond", target = "likedId")
    LikesDto mapToLikesDto(LikesEntity user);

    @Mapping(source = "likerId", target = "id.likerIdFirst")
    @Mapping(source = "likedId", target = "id.likerIdSecond")
    LikesEntity mapToLikesEntity(LikesDto dto);
}