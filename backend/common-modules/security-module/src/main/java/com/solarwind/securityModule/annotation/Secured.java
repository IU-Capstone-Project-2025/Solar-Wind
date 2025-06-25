package com.solarwind.securityModule.annotation;

import com.solarwind.securityModule.service.TokenSourceReader;
import java.lang.annotation.*;

@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD, ElementType.TYPE})
@Documented
public @interface Secured {
    Class<? extends TokenSourceReader> value();
}
