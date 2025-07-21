package dariamaria.gymbro.app.controllers;

import com.photoservice.service.PhotoService;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
@RequestMapping("/photo")
@RequiredArgsConstructor
public class PhotoController {

    private PhotoService photoService;

//    @PostMapping("/upload")
//    public ResponseEntity<String> uploadPhoto(@RequestParam("file") MultipartFile file,
//                                              @RequestParam("userId") Long userId) {
//        String filename = photoService.savePhoto(file, userId);
//        return ResponseEntity.ok("Файл загружен: " + filename);
//    }
//
//    @GetMapping("/{filename:.+}")
//    public ResponseEntity<Resource> getPhoto(@PathVariable String filename) throws MalformedURLException {
//        Path path = Paths.get("uploads/photos/" + filename);
//        Resource resource = new UrlResource(path.toUri());
//
//        if (!resource.exists()) {
//            return ResponseEntity.notFound().build();
//        }
//
//        return ResponseEntity.ok()
//                .contentType(MediaType.IMAGE_JPEG)
//                .body(resource);
//    }
}
