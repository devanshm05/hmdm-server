# Stage 1: Build the app using Maven
FROM maven:3.9.3-eclipse-temurin-17 AS build
WORKDIR /app

# Copy Maven files first to cache dependencies
COPY pom.xml .
COPY src ./src

# Build the JAR (skip tests for faster build)
RUN mvn clean package -DskipTests

# Stage 2: Run the JAR in a slim Java image
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy the built JAR from the first stage
COPY --from=build /app/target/hmdm-server.jar hmdm-server.jar

# Expose default HTTP port
EXPOSE 8080

# Start the application
CMD ["java", "-jar", "hmdm-server.jar"]
