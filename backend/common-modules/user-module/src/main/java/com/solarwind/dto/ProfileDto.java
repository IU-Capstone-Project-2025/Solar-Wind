package com.solarwind.dto;

import com.solarwind.models.Gender;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
public class ProfileDto {
    Long id;
    String username;
    String description;
//    LocalDate age;
//    Gender gender;
    String cityName;
    List<Integer> preferredGymTime;
    List<String> sportName;
}
