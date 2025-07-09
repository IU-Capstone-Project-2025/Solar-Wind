package com.solarwind.dto;

import com.solarwind.models.Gender;
import jakarta.validation.constraints.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@NoArgsConstructor
public class UserDto implements Serializable {
    Long id;
    Long telegramId;
    @Size(max = 50)
    String username;
    @Size(max = 50)
    String firstName;
    @Size(max = 50)
    String lastName;
    String description;
//    @NotNull
    @Min(5)
    @Max(120)
    Integer age;
//    @NotNull
    Gender gender;
    Boolean verified;
//    @NotNull
    Gender preferredGender;
    @NotNull
    Long cityId;
    @NotEmpty
    List<Integer> preferredGymTime;
    @NotEmpty
    List<Long> sportId;
}
