package com.solarwind.securityModule.models;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UserSecurityNode {
    @Id
    private Long id;

    @Column(unique = true, nullable = false)
    private String token;

    @Column
    private String role;
}
