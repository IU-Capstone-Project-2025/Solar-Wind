package dariamaria.gymbro.app.controllers;

import dariamaria.gymbro.app.services.CityService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/cities")
public class CityController {
    private final CityService cityService;

    public CityController(CityService cityService) {
        this.cityService = cityService;
    }

    @GetMapping("/russia")
    public List<String> russianCities() {
        return cityService.getAllCities();
    }
}
