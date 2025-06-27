package com.solarwind.dto;

import com.solarwind.models.Gender;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class UserDto {
    Long id;
    Long telegramId;
    String username;
    String firstName;
    String lastName;
    String description;
    Integer age;
    Gender gender;
    Boolean verified;
    Gender preferredGender;
    Long cityId;
    List<Integer> preferredGymTime;
    List<Long> sportId;
}