package com.solarwind.models;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.HashSet;
import java.util.Set;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    Long id;
    @Column(name = "telegram_id")
    Long telegramId;
    @Column(unique = true, nullable = false, name = "username")
    String username;
    @Column(name = "first_name")
    String firstName;
    @Column(name = "last_name")
    String lastName;
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
    @Column(name = "city")
    String city;
    @Column(name = "preferred_gym_time")
    private String preferredGymTime;
    @ElementCollection
    @CollectionTable(name="sports")
    private Set<String> sports = new HashSet<>();
    @PrePersist
    public void prePersist() {
        if (this.gender == null) {
            this.gender = Gender.MALE;
        }
        if (this.verified == null) {
            verified = false;
        }
    }
}
