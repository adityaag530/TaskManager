# Stage 1: Build the JAR file using Maven
FROM maven:3.8.6-openjdk-21 as builder

WORKDIR /app

# Copy the Maven wrapper and source code
COPY .mvn .mvn
COPY mvnw .
COPY pom.xml .
COPY src ./src

# Build the application and package it into a JAR
RUN ./mvnw clean package -DskipTests

# Stage 2: Run the application using a Java runtime
FROM eclipse-temurin:21-jdk

WORKDIR /app

# Copy the built JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port the app runs on
EXPOSE 8888

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
