package com.solarwind.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class LikesDto {

    private Long id;

    private Long likerId;   // id первого пользователя
    private Long likedId;   // id второго пользователя

    private boolean isFirstLikes;   // лайк от первого
    private boolean isSecondLikes;  // лайк от второго
}