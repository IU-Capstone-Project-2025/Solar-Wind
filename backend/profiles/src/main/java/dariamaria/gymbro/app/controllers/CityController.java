package dariamaria.gymbro.app.controllers;

import com.solarwind.models.CityEntity;
import dariamaria.gymbro.app.services.CityManagementService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/cities")
public class CityController {
    @Autowired
    private CityManagementService cityService;
    @GetMapping
    public List<CityEntity> getCities() {
        return cityService.getCities();
    }

    @GetMapping("/pagination")
    public List<CityEntity> getPaginationCities(@RequestParam("page") int page,
           @RequestParam("size") int size) {return cityService.getPartOfCities(page, size);}


    @GetMapping("/search")
    public List<CityEntity> searchCity(@RequestParam("word") String word) {return cityService.searchCity(word);}
}
