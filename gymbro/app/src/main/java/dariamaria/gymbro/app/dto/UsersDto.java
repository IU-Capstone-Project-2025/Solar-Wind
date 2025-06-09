package dariamaria.gymbro.app.dto;

import dariamaria.gymbro.app.models.Roles;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class UsersDto {
    Long id;
    @NotBlank
    String username;
    @Pattern(regexp = "^\\+\\d{11}$")
    String phoneNumber;
    String password;
    Roles role;
}
