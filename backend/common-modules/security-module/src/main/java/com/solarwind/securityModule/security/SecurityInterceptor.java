package com.solarwind.securityModule.security;

import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.dto.TokenData;
import com.solarwind.securityModule.service.TokenSourceReader;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.NonNull;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

@Component
public class SecurityInterceptor implements HandlerInterceptor {

    @Autowired
    private ApplicationContext applicationContext;

    @Override
    public boolean preHandle(
            @NonNull HttpServletRequest request,
            @NonNull HttpServletResponse response,
            @NonNull Object handler
    ) throws Exception {
        if (!(handler instanceof HandlerMethod handlerMethod)) {
            return true;
        }
        Secured secured = handlerMethod.getMethodAnnotation(Secured.class);
        if (secured == null) {
            secured = handlerMethod.getBeanType().getAnnotation(Secured.class);
        }
        if (secured == null) {
            return true;
        }
        Class<? extends TokenSourceReader> tokenSourceClass = secured.value();
        TokenSourceReader tokenSource = applicationContext.getBean(tokenSourceClass);

        TokenData tokenData = tokenSource.extractToken(request);
        if (tokenData == null || !tokenSource.isValid(tokenData)) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Invalid token");
            return false;
        }
        return true;
    }
}
