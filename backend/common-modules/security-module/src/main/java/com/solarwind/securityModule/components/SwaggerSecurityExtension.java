package com.solarwind.securityModule.components;

import com.solarwind.securityModule.annotation.Secured;
import com.solarwind.securityModule.service.DatabaseSourceReader;
import com.solarwind.securityModule.service.PropertyTokenSourceReader;
import com.solarwind.securityModule.service.TokenSourceReader;
import io.swagger.v3.oas.models.Operation;
import io.swagger.v3.oas.models.parameters.Parameter;
import io.swagger.v3.oas.models.media.StringSchema;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springdoc.core.customizers.OperationCustomizer;


@Component
public class SwaggerSecurityExtension implements OperationCustomizer {

    @Override
    public Operation customize(Operation operation, HandlerMethod handlerMethod) {
        Secured secured = handlerMethod.getMethodAnnotation(Secured.class);
        if (secured == null) {
            secured = handlerMethod.getBeanType().getAnnotation(Secured.class);
        }
        if (secured == null) {
            return operation;
        }
        Class<? extends TokenSourceReader> tokenSource = secured.value();

        if (tokenSource.equals(DatabaseSourceReader.class)) {
            addHeader(operation, "Authorize", "Access token");
            addHeader(operation, "Authorization-telegram-id", "Telegram User ID");
        } else if (tokenSource.equals(PropertyTokenSourceReader.class)) {
            addHeader(operation, "Authorize", "Simple token");
        }

        return operation;
    }

    private void addHeader(Operation operation, String name, String description) {
        if (operation.getParameters() != null && operation.getParameters().stream()
                .anyMatch(p -> name.equalsIgnoreCase(p.getName()))) {
            return;
        }

        Parameter header = new Parameter()
                .in("header")
                .required(true)
                .name(name)
                .description(description)
                .schema(new StringSchema());

        operation.addParametersItem(header);
    }
}
