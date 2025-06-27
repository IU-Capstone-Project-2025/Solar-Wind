package com.solarwind.repositories;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface SportRepository extends JpaRepository<SportEntity, Long> {
    @Query(value = "SELECT * FROM sport WHERE sport_type ILIKE CONCAT(:word, '%') LIMIT 10",
            nativeQuery = true)
    public List<SportEntity> findByWord(@Param("word") String word);
}
