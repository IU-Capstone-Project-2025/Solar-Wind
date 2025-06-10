package dariamaria.gymbro.app.models;

import com.fasterxml.jackson.annotation.JsonValue;

public enum Roles {
    USER ("user"),
    ADMIN ("admin");

    private final String name;

    private Roles(String s) {
        name = s;
    }

    public boolean equalsName(String otherName) {
        return name.equals(otherName);
    }

    @JsonValue  // При сериализации enum -> строка
    public String toString() {
        return this.name;
    }
}