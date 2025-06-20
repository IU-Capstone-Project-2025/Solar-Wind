package dariamaria.gymbro.app.controllers;

import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

import static java.nio.charset.StandardCharsets.UTF_8;

@RestController
@RequestMapping("/auth/telegram")
public class AuthController {
    private final String tgBotToken = "7727350068:AAFDInaLmrhRlVT4EXOp3R_QT2ToupoNEA8";

    @GetMapping
    public ResponseEntity<Resource> getAuthScript() {
        Resource resource = new ClassPathResource("login/login.html");
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
}