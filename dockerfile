# Multi-stage build for Spring Boot application

# Build stage
FROM maven:3.9-eclipse-temurin-21-alpine AS build

# Set working directory
WORKDIR /app

# Copy pom.xml first to leverage Docker cache
COPY pom.xml .

# Copy the source code
COPY src ./src

# Copy the data directory if needed
COPY data ./data

# Copy Maven wrapper files
COPY mvnw .
COPY .mvn ./.mvn 2>/dev/null || true

# Make mvnw executable
RUN chmod +x mvnw

# Build the application
RUN --mount=type=cache,target=/root/.m2 ./mvnw clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:21-jre-alpine

# Set working directory
WORKDIR /app

# Copy the jar file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Copy data directory if needed for runtime
COPY --from=build /app/data ./data

# Expose the port the app runs on
EXPOSE 8888

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
