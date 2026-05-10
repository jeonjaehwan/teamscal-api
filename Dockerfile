FROM openjdk:17-jdk-slim
WORKDIR /app
COPY build/libs/teamscal-api-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.profiles.active=prod"]