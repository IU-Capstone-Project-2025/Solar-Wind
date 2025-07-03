package com.solarwind.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Entity
@Data
@NoArgsConstructor
@Table(name = "users")
public class UserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    Long id;
    @Column(name = "telegram_id")
    Long telegramId;
    @Column(unique = true, name = "username")
    String username;
    @Column(name = "first_name")
    String firstName;
    @Column(name = "last_name")
    String lastName;
    @Column(name = "description")
    String description;
    @Column(name = "age")
    Integer age;
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
