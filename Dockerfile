# Use Java 17
FROM openjdk:17-jdk-slim

WORKDIR /app

# Copy WAR file
COPY target/TrainBook-1.0.0-SNAPSHOT.war /app/TrainBook.war

# Run WAR
CMD ["java", "-jar", "/app/TrainBook.war"]
