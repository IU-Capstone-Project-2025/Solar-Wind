package com.solarwind.repositories;

import com.solarwind.dto.UserDto;
import com.solarwind.models.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.LinkedList;
import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    @Query(value = "SELECT id FROM user WHERE city_id = :city " +
            "and age >= :age-10 and age <= :age+10 and gender = :preferred " +
            "and preferred_gender = :gender and verified = true", nativeQuery = true)
    public List<Long> findByConstParams(@Param("gender") String gender,
                                              @Param("preferred") String preffered,
                                              @Param("city")Long city,
                                              @Param("age") int age);

    @Query(value = "WITH unsorted_users AS (" +
            "    SELECT id FROM users WHERE city_id = :city " +
            "    AND age >= (:age - 10) AND age <= (:age + 10) " +
            "    AND LOWER(gender) = LOWER(:preferred) " +
            "    AND LOWER(preferred_gender) = LOWER(:gender) " +
//            "    AND verified = true" +
            "), " +
            "initial_user_sport AS (" +
            "    SELECT sport_id FROM user_sport WHERE user_id = :initial_id" +
            "), " +
            "matched_users AS (" +
            "    SELECT u.id, COUNT(us.sport_id) AS matched_sports_count " +
            "    FROM unsorted_users u " +
            "    JOIN user_sport us ON u.id = us.user_id " +
            "    JOIN initial_user_sport ius ON us.sport_id = ius.sport_id " +
            "    GROUP BY u.id " +
            ") " +
            "SELECT id FROM matched_users " +
            "ORDER BY matched_sports_count DESC",
            nativeQuery = true)
    public List<Long> createDeckWithoutTime(@Param("gender") String gender,
                                 @Param("preferred") String preffered,
                                 @Param("city")Long city,
                                 @Param("age") int age,
                                 @Param("initial_id") Long initial_id);

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
        ORDER BY mu.matched_sports_count DESC, mu.matched_days_count DESC
    """, nativeQuery = true)
    List<UserEntity> createDeckAllSettings(
            @Param("gender") String gender,
            @Param("preferred") String preferred,
            @Param("city") Long city,
            @Param("age") int age,
            @Param("initial_id") Long initial_id
    );

    @Query(value = "SELECT id FROM users WHERE username = :username", nativeQuery = true)
    public Long findIdByUsername(@Param("username") String username);
}
