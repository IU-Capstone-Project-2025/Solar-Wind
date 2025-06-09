package dariamaria.gymbro.app.dto.mappers;

import dariamaria.gymbro.app.dto.UsersDto;
import dariamaria.gymbro.app.models.Users;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UserMapper {
    public UsersDto mapToUsersDto(Users entity) {
        UsersDto dto = new UsersDto();
        dto.setId(entity.getId());
        dto.setUsername(entity.getUsername());
        dto.setPhoneNumber(entity.getPhoneNumber());
        dto.setPassword(entity.getPassword());
        dto.setRole(entity.getRole());
        return dto;
    }
    public Users mapToUsersEntity(UsersDto dto) {
        Users entity = new Users();
        entity.setUsername(dto.getUsername());
        entity.setPhoneNumber(dto.getPhoneNumber());
        entity.setPassword(dto.getPassword());
        entity.setRole(dto.getRole());
        return entity;
    }
}
