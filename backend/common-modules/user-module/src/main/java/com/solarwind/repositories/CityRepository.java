package com.solarwind.repositories;

import com.solarwind.models.CityEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CityRepository extends JpaRepository<CityEntity, Long> {
    @Query(value = "SELECT * FROM city WHERE city_name ILIKE CONCAT(:word, '%')",
            nativeQuery = true)
    public List<CityEntity> findByWord(@Param("word") String word);
}
