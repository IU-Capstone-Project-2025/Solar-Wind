package dariamaria.gymbro.app.mappers;

import com.solarwind.dto.UserDto;
import com.solarwind.models.UserEntity;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface UserMapper {
    UserDto mapToUsersDto(UserEntity user);
    UserEntity mapToUsersEntity(UserDto dto);
}