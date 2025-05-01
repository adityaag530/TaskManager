# Use official Java 21 base image
FROM eclipse-temurin:21-jdk AS builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml and source code
COPY pom.xml .
COPY src ./src

# Build the project
RUN mvn clean package -DskipTests

# Use the official Java 21 image to run the app
FROM eclipse-temurin:21-jdk

# Set the working directory
WORKDIR /app

# Copy the fat JAR from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the port Render expects (must match PORT env)
EXPOSE 8888

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
