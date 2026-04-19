# Stage 1: Build
FROM azul/zulu-openjdk:21 AS build
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline -Pall -B
COPY src ./src
COPY config ./config
RUN mvn package -Pall -DskipTests -B

# Stage 2: Run
FROM azul/zulu-openjdk:21-jre
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
COPY config ./config

# Sonic Pi example song directories - mount from host via docker-compose volumes.
# Spring Boot relaxed binding: hyphens are removed when mapping to env vars.
ENV SONICPI_EXAMPLES_SONICPIAPPDIR=/app/sonic-pi-examples
ENV SONICPI_EXAMPLES_USERDIR=/app/user-songs

EXPOSE 48080
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.config.additional-location=file:/app/config/all/"]
