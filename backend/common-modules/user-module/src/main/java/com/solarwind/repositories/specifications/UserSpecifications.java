package com.solarwind.repositories.specifications;

import com.solarwind.component.MapperHelper;
import com.solarwind.models.Gender;
import com.solarwind.models.UserEntity;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.domain.Specification;

import java.time.LocalDate;
import java.util.List;

@NoArgsConstructor
public class UserSpecifications {

    private static MapperHelper helper;

    public static Specification<UserEntity> hasCity(Long cityId) {
        return (root, query, cb) ->
                cityId == null ? null : cb.equal(root.get("city").get("id"), cityId);
    }

    public static Specification<UserEntity> hasGender(Gender gender) {
        return (root, query, cb) ->
                gender == null ? null : cb.equal(root.get("gender"), gender);
    }

    public static Specification<UserEntity> hasPreferredGender(Gender preferredGender) {
        return (root, query, cb) ->
                preferredGender == null ? null : cb.equal(root.get("preferredGender"), preferredGender);
    }

    public static Specification<UserEntity> hasAge(LocalDate age) {
        return (root, query, cb) -> {
            if (age == null) return null;

            LocalDate minDate = age.minusYears(5);
            LocalDate maxDate = age.plusYears(5);

            return cb.between(root.get("age"), minDate, maxDate);
        };
    }

    public static Specification<UserEntity> hasPreferredGymTimeIn(List<Integer> preferredGymTimes) {
        return (root, query, cb) -> {
            if (preferredGymTimes == null || preferredGymTimes.isEmpty()) {
                return null;
            }
            Integer bitMask = helper.mapGymTimeToBits(preferredGymTimes);

            return cb.notEqual(
                    cb.function("bitand", Integer.class, root.get("preferredGymTime"), cb.literal(bitMask)),
                    0
            );
        };
    }

    public static Specification<UserEntity> hasAnySportId(List<Long> sportIds) {
        return (root, query, cb) -> {
            if (sportIds == null || sportIds.isEmpty()) {
                return null;
            }
            return root.join("sports").get("id").in(sportIds);
        };
    }

    public static Specification<UserEntity> excludeUserId(Long id) {
        return (root, query, cb) -> cb.notEqual(root.get("id"), id);
    }
}
