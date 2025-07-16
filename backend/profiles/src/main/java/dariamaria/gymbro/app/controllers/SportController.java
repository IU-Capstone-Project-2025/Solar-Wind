package dariamaria.gymbro.app.controllers;

import com.solarwind.models.CityEntity;
import com.solarwind.models.SportEntity;
import dariamaria.gymbro.app.services.SportManagementService;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@NoArgsConstructor
@RequestMapping("/api/sports")
public class SportController {
    @Autowired
    private SportManagementService sportService;

    @GetMapping
    public List<SportEntity> getSports(){
        return sportService.getSports();
    }

    @GetMapping("/pagination")
    public List<SportEntity> getPaginationSports(@RequestParam("page") int page,
                                                @RequestParam("size") int size) {return sportService.getPartOfSports(page, size);}

    @GetMapping("/search")
    public List<SportEntity> searchSport(@RequestParam("word") String word) {return sportService.searchSport(word);}
}