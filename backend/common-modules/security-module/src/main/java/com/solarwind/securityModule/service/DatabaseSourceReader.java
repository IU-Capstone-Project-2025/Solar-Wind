package com.solarwind.securityModule.service;

import com.solarwind.securityModule.dto.TokenData;
import com.solarwind.securityModule.exceptions.AccessorNotFoundException;
import com.solarwind.securityModule.models.UserSecurityNode;
import com.solarwind.securityModule.repositories.TokensRepository;
import com.solarwind.securityModule.security.SecurityInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Example;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.server.ResponseStatusException;

@Service
public class DatabaseSourceReader implements TokenSourceReader {
    @Autowired
    private TokensRepository tokenSourceRepository;

    private static final Logger logger = LoggerFactory.getLogger(DatabaseSourceReader.class);

    @Override
    public TokenData extractToken(HttpServletRequest request) {
        if (request.getHeader("Authorization-telegram-id") == null ||  request.getHeader("Authorize") == null) {
            logger.info("No auth header was providen");
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST);
        }
        Long id = Long.parseLong(request.getHeader("Authorization-telegram-id"));
        String token = request.getHeader("Authorize");
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
