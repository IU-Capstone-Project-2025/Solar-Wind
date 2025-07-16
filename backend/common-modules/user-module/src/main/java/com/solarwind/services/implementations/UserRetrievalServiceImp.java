package com.solarwind.services.implementations;

import com.solarwind.dto.ProfileDto;
import com.solarwind.dto.UserDto;
import com.solarwind.mappers.ProfileMapper;
import com.solarwind.mappers.UserMapper;
import com.solarwind.repositories.UserRepository;
import com.solarwind.services.UserRetrievalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class  UserRetrievalServiceImp implements UserRetrievalService {
    @Autowired
    protected UserRepository repository;
    @Autowired
    protected UserMapper userMapper;
    @Autowired
    protected ProfileMapper profileMapper;
    @Override
    public ProfileDto getByUserId(long id) {
        return profileMapper.mapToProfileDto(repository.getById(id));
    }

    @Override
    public List<ProfileDto> getUsers() {
        return repository.findAll()
                .stream()
                .map(user -> profileMapper.mapToProfileDto(user))
                .collect(Collectors.toList());
    }
}
