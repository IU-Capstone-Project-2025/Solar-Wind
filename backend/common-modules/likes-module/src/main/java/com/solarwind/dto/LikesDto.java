package com.solarwind.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LikesDto {
    private Long likerId;   // id первого пользователя
    private Long likedId;   // id второго пользователя

    private Boolean isFirstLikes;   // лайк от первого
    private Boolean isSecondLikes;  // лайк от второго
}