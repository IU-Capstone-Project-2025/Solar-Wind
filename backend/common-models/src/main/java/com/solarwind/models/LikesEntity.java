package com.solarwind.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "likes")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LikesEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    private Long id;

    // First user
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "liker_id_first", nullable = false)
    private UserEntity likerFirst;

    // Second user
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "liker_id_second", nullable = false)
    private UserEntity likerSecond;

    // Solution of like for first
    @Column(name = "is_first_likes", nullable = false)
    private boolean isFirstLikes;

    // Solution of like for second
    @Column(name = "is_second_likes", nullable = false)
    private boolean isSecondLikes;
}
