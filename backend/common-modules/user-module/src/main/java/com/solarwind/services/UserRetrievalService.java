package com.solarwind.services;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;

import java.util.List;

public interface UserRetrievalService {
    ProfileDto getByUserId(long id);
    List<ProfileDto> getUsers();
}
