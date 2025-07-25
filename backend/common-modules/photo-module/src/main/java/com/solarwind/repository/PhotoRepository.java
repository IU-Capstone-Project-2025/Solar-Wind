package com.solarwind.repository;

import com.solarwind.model.PhotoEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PhotoRepository extends JpaRepository<PhotoEntity, Long> {
    Optional<PhotoEntity> findByImage(byte[] image);
    Optional<PhotoEntity> findByUserId(long id);
}
