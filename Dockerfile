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

# Sonic Pi example song directories - mount from host at runtime:
#   docker run -v /Applications/Sonic Pi.app/Contents/Resources/etc/examples:/app/sonic-pi-examples \
#              -v ~/code/sonicpi:/app/user-songs ...
ENV SONIC_PI_EXAMPLES_SONIC_PI_APP_DIR=/app/sonic-pi-examples
ENV SONIC_PI_EXAMPLES_USER_DIR=/app/user-songs

EXPOSE 48080
ENTRYPOINT ["java", "-jar", "app.jar", "--spring.config.additional-location=file:/app/config/all/"]
