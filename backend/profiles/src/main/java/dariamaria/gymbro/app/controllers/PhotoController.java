package dariamaria.gymbro.app.controllers;

import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.DatabaseSourceReader;
import dariamaria.gymbro.app.services.UserManagementService;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

import java.io.IOException;

@Secured(DatabaseSourceReader.class)
@RestController
@RequestMapping("/api/photo")
@RequiredArgsConstructor
public class PhotoController {
    @Autowired
    private UserManagementService service;
    @PostMapping("/save")
    public void savePhoto(@RequestHeader("Authorization-telegram-id") long id, @RequestParam MultipartFile photo) { //
        System.out.println("start saving photo");
        try {
            service.savePhoto(id, photo.getBytes());
        } catch (EntityNotFoundException | IOException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/get")
    public ResponseEntity<byte[]> getPhoto(@RequestHeader("Authorization-telegram-id") long id) {
        try {
            byte[] photo = service.getPhoto(id);
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_JPEG);
            return new ResponseEntity<>(photo, headers, HttpStatus.OK);
        } catch (EntityNotFoundException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND);
        }
    }
}
