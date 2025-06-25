package com.solarwind.securityModule.repositories;

import com.solarwind.securityModule.models.UserSecurityNode;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TokensRepository extends JpaRepository<UserSecurityNode, Long> {
}
