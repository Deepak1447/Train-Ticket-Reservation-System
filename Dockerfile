# Use a Java 17 base image
FROM openjdk:17-jdk-slim

# Set working directory inside container
WORKDIR /app

# Copy the built jar file from your local build
# (Assumes you run `mvn clean package` before building this Docker)
COPY target/TrainBook-1.0.0-SNAPSHOT.war /app/TrainBook.war

# Expose port your application listens on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

