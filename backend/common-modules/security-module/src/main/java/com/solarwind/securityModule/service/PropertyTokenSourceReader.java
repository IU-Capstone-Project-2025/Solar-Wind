package com.solarwind.securityModule.service;

import com.solarwind.securityModule.dto.TokenData;
import com.solarwind.securityModule.exceptions.AccessorNotFoundException;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

@Service
@ConfigurationProperties(prefix = "security-accessors")
public class PropertyTokenSourceReader implements TokenSourceReader {
    private Set<String> accessors = new HashSet<>();

    @Override
    public TokenData extractToken(HttpServletRequest request){
        String token = request.getHeader("Authorize");
        return new TokenData(null, token);
    }

    @Override
    public boolean isValid(TokenData tokenData) throws AccessorNotFoundException {
        if (!accessors.contains(tokenData.token())) {
            throw new AccessorNotFoundException();
        }
        return true;
    }
}
