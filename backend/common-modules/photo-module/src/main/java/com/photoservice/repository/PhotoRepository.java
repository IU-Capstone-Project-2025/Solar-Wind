package com.photoservice.repository;

import com.photoservice.models.PhotoEntity;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PhotoRepository extends JpaRepository<PhotoEntity, Long> {
    Optional<PhotoEntity> findByImage(byte[] image);
}
