# Use official Java 21 base image
FROM eclipse-temurin:21-jdk

# Set the working directory
WORKDIR /app

# Copy the fat jar (adjust the jar name if needed)
COPY target/*.jar app.jar

# Expose the port Render expects (must match PORT env)
EXPOSE 8888

# Start the application
ENTRYPOINT ["java", "-jar", "app.jar"]
