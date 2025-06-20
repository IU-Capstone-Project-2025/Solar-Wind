package com.solarwind.services;

import com.solarwind.dto.UserDto;

import java.util.List;

public interface UserRetrievalService {
    UserDto getByUserId(long id);
    List<UserDto> getUsers();
}
