package com.solarwind.dto;

import com.solarwind.models.Gender;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Set;

@Data
@NoArgsConstructor
public class UsersDto {
    Long id;
    @NotBlank
    String username;
    Long telegramId;
    String firstName;
    String lastName;
    Integer age;
    Gender gender;
    Boolean verified;
    Gender preferredGender;
    String city;
    String preferredGymTime;

    Set<String> sportNames;

}