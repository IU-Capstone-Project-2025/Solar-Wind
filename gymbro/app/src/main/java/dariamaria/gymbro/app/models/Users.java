package dariamaria.gymbro.app.models;

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
public class Users {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    Long id;
    @Column(unique = true, nullable = false, name = "username")
    String username;
    @Column(nullable = false, name = "password")
    String password;
    @Column(name = "phoneNumber")
    String phoneNumber;
    @Enumerated(EnumType.STRING)
    @Column (name = "role")
    Roles role;
    @PrePersist
    public void prePersist() {
        if (this.role == null) {
            this.role = Roles.USER;
        }
    }
}
