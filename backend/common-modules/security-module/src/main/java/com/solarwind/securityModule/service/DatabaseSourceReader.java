package com.solarwind.securityModule.service;

import com.solarwind.securityModule.dto.TokenData;
import com.solarwind.securityModule.exceptions.AccessorNotFoundException;
import com.solarwind.securityModule.models.UserSecurityNode;
import com.solarwind.securityModule.repositories.TokensRepository;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.data.domain.Example;
import org.springframework.stereotype.Service;

@Service
public class DatabaseSourceReader implements TokenSourceReader {
    private final TokensRepository tokenSourceRepository;

    public DatabaseSourceReader(TokensRepository tokenSourceRepository) {
        this.tokenSourceRepository = tokenSourceRepository;
    }

    @Override
    public TokenData extractToken(HttpServletRequest request) {
        Long id = Long.parseLong(request.getHeader("Authorization-telegram-id"));
        String token = request.getHeader("Authorization");
        return new TokenData(id, token);
    }

    @Override
    public boolean isValid(TokenData tokenData) throws AccessorNotFoundException {
        UserSecurityNode example = new UserSecurityNode();
        example.setId(tokenData.id());
        var node = tokenSourceRepository.findOne(Example.of(example));
        if (node.isEmpty()){
            throw new AccessorNotFoundException();
        }
        return node.get().getToken().equals(tokenData.token());
    }
}
