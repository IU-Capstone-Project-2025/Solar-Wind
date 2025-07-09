package com.solarwind.repositories;

import com.solarwind.models.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long>, JpaSpecificationExecutor<UserEntity> {
    @Query(value = """
            WITH unsorted_users AS (
        SELECT id, preferred_gym_time
        FROM users
        WHERE city_id = :city
          AND age BETWEEN (:age - 10) AND (:age + 10)
          AND LOWER(gender) = LOWER(:preferred)
          AND LOWER(preferred_gender) = LOWER(:gender)
    ),
    initial_user AS (
        SELECT preferred_gym_time FROM users WHERE id = :initial_id
    ),
    initial_user_sport AS (
        SELECT sport_id FROM user_sport WHERE user_id = :initial_id
    ),
    matched_users AS (
        SELECT u.id,
            u.preferred_gym_time,
            COUNT(us.sport_id) AS matched_sports_count,
            length(replace(lpad((u.preferred_gym_time & iu.preferred_gym_time)::bit(7)::text, 7, '0'), '0', '')) AS matched_days_count
        FROM unsorted_users u
        CROSS JOIN initial_user iu
        JOIN user_sport us ON u.id = us.user_id
        JOIN initial_user_sport ius ON us.sport_id = ius.sport_id
        GROUP BY u.id, u.preferred_gym_time, iu.preferred_gym_time
    )
        SELECT u.*,
        mu.matched_sports_count,
        mu.matched_days_count
        FROM matched_users mu
        JOIN users u ON u.id = mu.id
        WHERE u.id != :initial_id
        ORDER BY mu.matched_sports_count DESC, mu.matched_days_count DESC
    """, nativeQuery = true)
    List<UserEntity> createDeckAllSettings(
            @Param("gender") String gender,
            @Param("preferred") String preferred,
            @Param("city") Long city,
            @Param("age") LocalDate age,
            @Param("initial_id") Long initial_id
    );

    @Query(value = "SELECT id FROM users WHERE username = :username", nativeQuery = true)
    public Long findIdByUsername(@Param("username") String username);
}
