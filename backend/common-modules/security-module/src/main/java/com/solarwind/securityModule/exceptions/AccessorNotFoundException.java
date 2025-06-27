package com.solarwind.securityModule.exceptions;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(code = HttpStatus.UNAUTHORIZED, reason = "Accessor does not found as registered")
public class AccessorNotFoundException extends Exception {
}