package com.solarwind.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@Table(name = "users")
public class UserEntity {
    @Id
    @Column(name = "id", nullable = false)
    Long id;
    @Column(name = "telegram_id")
    Long telegramId;
    @Column(unique = true, name = "username")
    String username;
    @Column(name = "description")
    String description;
    @Column(name = "age")
    LocalDate age;
    @Enumerated(EnumType.STRING)
    @Column (name = "gender")
    Gender gender;
    @Column(name = "verified")
    Boolean verified;
    @Enumerated(EnumType.STRING)
    @Column (name = "preferred_gender")
    Gender preferredGender;
    @ManyToOne
    @JoinColumn(name = "city_id")
    CityEntity city;
    @Column(name = "preferred_gym_time")
    Integer preferredGymTime;
    @ManyToMany
    @JoinTable(
            name = "user_sport",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "sport_id")
    )
    List<SportEntity> sports;
    @Column(name="phoho_id")
    Long photoId;
    @PrePersist
    public void prePersist() {
        if (this.gender == null) {
            this.gender = Gender.MALE;
        }
        if (this.preferredGender == null) {
            this.preferredGender = Gender.MALE;
        }
        if (this.verified == null) {
            verified = false;
        }
    }
}
