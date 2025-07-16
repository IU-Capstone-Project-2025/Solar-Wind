package com.solarwind.securityModule.service;

import com.solarwind.securityModule.dto.TokenData;
import com.solarwind.securityModule.exceptions.AccessorNotFoundException;
import jakarta.servlet.http.HttpServletRequest;

public interface TokenSourceReader {
    TokenData extractToken(HttpServletRequest request);

    boolean isValid(TokenData tokenData) throws AccessorNotFoundException;
}