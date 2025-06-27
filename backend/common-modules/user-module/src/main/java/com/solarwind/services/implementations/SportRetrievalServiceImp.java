package com.solarwind.services.implementations;

import com.solarwind.models.SportEntity;
import com.solarwind.repositories.SportRepository;
import com.solarwind.services.SportRetrievalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SportRetrievalServiceImp implements SportRetrievalService {
    @Autowired
    private SportRepository sportRepository;

    @Override
    public List<SportEntity> getSports() {
        return sportRepository.findAll();
    }
}
