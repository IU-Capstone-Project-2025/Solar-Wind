package com.solarwind.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LikesEntity {

    @EmbeddedId
    private LikesCompositePrimaryKey id;

    @Column(name = "is_first_likes")
    private Boolean isFirstLikes;

    @Column(name = "is_second_likes")
    private Boolean isSecondLikes;
}
