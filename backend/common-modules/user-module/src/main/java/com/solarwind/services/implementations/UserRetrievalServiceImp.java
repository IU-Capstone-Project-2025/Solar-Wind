package com.solarwind.services.implementations;

import com.solarwind.dto.UserDto;
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
    protected UserMapper mapper;
    @Override
    public UserDto getByUserId(long id) {
        return mapper.mapToUsersDto(repository.getById(id));
    }

    @Override
    public List<UserDto> getUsers() {
        return repository.findAll()
                .stream()
                .map(user -> mapper.mapToUsersDto(user))
                .collect(Collectors.toList());
    }
}
