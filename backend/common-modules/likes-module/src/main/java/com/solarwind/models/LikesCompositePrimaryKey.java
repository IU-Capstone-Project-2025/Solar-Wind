package com.solarwind.models;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class LikesCompositePrimaryKey implements Serializable {

    @Column(name = "liker_id_first", nullable = false)
    private Long likerIdFirst;

    @Column(name = "liker_id_second", nullable = false)
    private Long likerIdSecond;
}
