# Stage 1: Build the Application
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app

# Copy dependency files and source code
COPY pom.xml .
COPY src ./src

# Package the application without running tests or security scanners
RUN mvn clean package -DskipTests

# Stage 2: Runtime Environment
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# Copy the built jar from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
