FROM eclipse-temurin:21-jdk-alpine AS dependencies
WORKDIR /app
COPY pom.xml mvnw ./
COPY .mvn .mvn
RUN echo "===== ls -la in /app =====" && ls -la /app && file ./mvnw
RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

FROM eclipse-temurin:21-jdk-alpine AS build
WORKDIR /app
COPY --from=dependencies /app /app
COPY . .
RUN ./mvnw clean package -DskipTests

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
