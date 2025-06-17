package com.solarwind.dto;
public record TelegramAuthRequest(
        Long id,
        String first_name,
        String last_name,
        String username,
        String photo_url,
        String auth_date,
        String hash
) {}