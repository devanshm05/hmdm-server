# ------------------------------
# Dockerfile for Headwind MDM (Render compatible)
# ------------------------------

    FROM gradle:7.6.2-jdk17 AS builder
    WORKDIR /app
    
    # Copy everything
    COPY . .
    
    # If Gradle files are inside /server (most likely)
    WORKDIR /app/server
    
    # Build the project
    RUN gradle build --no-daemon
    
    # ------------------------------
    # Final runtime image
    # ------------------------------
    FROM openjdk:17-jdk-slim
    WORKDIR /app
    
    # Copy jar from builder
    COPY --from=builder /app/server/build/libs/*.jar /app/hmdm-server.jar
    
    EXPOSE 8080
    
    ENTRYPOINT ["java", "-jar", "/app/hmdm-server.jar"]
    