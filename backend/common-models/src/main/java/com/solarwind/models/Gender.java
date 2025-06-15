package com.solarwind.models;

import com.fasterxml.jackson.annotation.JsonValue;

public enum Gender {
    MALE ("male"),
    FEMALE ("female");

    private final String name;

    private Gender(String s) {
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