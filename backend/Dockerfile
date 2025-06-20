# Common file for each service. Directory with context should be passed separately as a context.
# Project should be compiled before the building the image.
# Compilation stages was removed because of multimoduled nature of the project.

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
COPY target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
