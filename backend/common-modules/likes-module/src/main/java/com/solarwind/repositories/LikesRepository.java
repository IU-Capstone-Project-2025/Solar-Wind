package com.solarwind.repositories;

import com.solarwind.models.LikesEntity;
import org.springframework.data.jpa.repository.JpaRepository;

public interface LikesRepository extends JpaRepository<LikesEntity, Long> {
}
