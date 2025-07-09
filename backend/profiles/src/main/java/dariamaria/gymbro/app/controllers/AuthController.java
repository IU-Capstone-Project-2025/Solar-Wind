package dariamaria.gymbro.app.controllers;

import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.PropertyTokenSourceReader;
import dariamaria.gymbro.app.services.implementation.AuthService;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;
import com.github.benmanes.caffeine.cache.Cache;
import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.web.server.ResponseStatusException;

import java.util.concurrent.TimeUnit;

import static java.nio.charset.StandardCharsets.UTF_8;

@RestController
@NoArgsConstructor
@RequestMapping("/auth/telegram")
public class AuthController {
    @Value("${telegram.bot-token}")
    private String tgBotToken;
    @Autowired
    private AuthService authService;
    private final Cache<Integer, Long> code_awaiters = Caffeine
            .newBuilder()
            .expireAfterWrite(60, TimeUnit.SECONDS)
            .build();


    @GetMapping
    public ResponseEntity<Resource> getAuthScript() {
        Resource resource = new ClassPathResource("login/login.html"); // для проверки работы кнопки
        var headers = new HttpHeaders();
        headers.add(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=telegramAuth.html");
        return ResponseEntity.ok().headers(headers).body(resource);
    }

    /**
     * сюда отправляются данные, полученные после аутентификации
     */
    @PostMapping
    public String authenticate(@RequestBody Map<String, Object> telegramData) {
        return telegramDataIsValid(telegramData) ? "pretend-that-it-is-your-token" : "error";
    }

    /**
     * проверяет данные, полученные из телеграм
     */
    private boolean telegramDataIsValid(Map<String, Object> telegramData) {
        //получаем хэш, который позже будем сравнивать с остальными данными
        String hash = (String) telegramData.get("hash");
        telegramData.remove("hash");

        //создаем строку проверки - сортируем все параметры и объединяем их в строку вида:
        //auth_date=<auth_date>\nfirst_name=<first_name>\nid=<id>\nusername=<username>
        StringBuilder sb = new StringBuilder();
        telegramData.entrySet().stream()
                .sorted(Map.Entry.comparingByKey())
                .forEach(entry -> sb.append(entry.getKey()).append("=").append(entry.getValue()).append("\n"));
        sb.deleteCharAt(sb.length() - 1);
        String dataCheckString = sb.toString();

        try {
            //генерируем SHA-256 хэш из токена бота
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] key = digest.digest(tgBotToken.getBytes(UTF_8));

            //создаем HMAC со сгенерированным хэшем
            Mac hmac = Mac.getInstance("HmacSHA256");
            SecretKeySpec secretKeySpec = new SecretKeySpec(key, "HmacSHA256");
            hmac.init(secretKeySpec);

            // добавляем в HMAC строку проверки и переводим в шестнадцатеричный формат
            byte[] hmacBytes = hmac.doFinal(dataCheckString.getBytes(UTF_8));
            StringBuilder validateHash = new StringBuilder();
            for (byte b : hmacBytes) {
                validateHash.append(String.format("%02x", b));
            }

            // сравниваем полученный от телеграма и сгенерированный хэш
            return hash.contentEquals(validateHash);
        } catch (NoSuchAlgorithmException | InvalidKeyException e) {
            throw new RuntimeException(e);
        }
    }

    @Secured(PropertyTokenSourceReader.class)
    @PostMapping("/custom-auth")
    public void postMatchingCode(@RequestParam Integer code, @RequestParam Long userId) {
        code_awaiters.put(code, userId);
    }

    @GetMapping("/custom-auth")
    public ResponseEntity<Map<String, String>> getCustomAuthToken(@RequestParam Integer code) {
        Long userId = code_awaiters.getIfPresent(code);
        if (userId == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }

        String token = authService.obtainPersonalToken(userId);
        Map<String, String> response = new HashMap<>();
        response.put("token", token);
        response.put("id", userId.toString());

        return new ResponseEntity<>(response, HttpStatus.OK);
    }
}