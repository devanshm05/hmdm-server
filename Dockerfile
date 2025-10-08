# ------------------------------
# Dockerfile for Headwind MDM
# ------------------------------

# Base image with Java + Gradle
FROM gradle:7.6.2-jdk17 AS builder
WORKDIR /app

# Copy all source code
COPY . .

# Build the project
RUN gradle build --no-daemon

# ------------------------------
# Final runtime image
# ------------------------------
FROM openjdk:17-jdk-slim
WORKDIR /app

# Copy built jar from builder
COPY --from=builder /app/build/libs/hmdm-server-*.jar /app/hmdm-server.jar

# Expose default port
EXPOSE 8080

# Run the server
ENTRYPOINT ["java", "-jar", "/app/hmdm-server.jar"]
