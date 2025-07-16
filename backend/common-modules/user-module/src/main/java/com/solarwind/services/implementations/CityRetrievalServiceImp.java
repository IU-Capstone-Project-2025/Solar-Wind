package com.solarwind.services.implementations;

import com.solarwind.models.CityEntity;
import com.solarwind.repositories.CityRepository;
import com.solarwind.services.CityRetrievalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CityRetrievalServiceImp implements CityRetrievalService {
    @Autowired
    private CityRepository cityRepository;
    @Override
    public List<CityEntity> getCities() {
        return cityRepository.findAll();
    }
}
