# Docker Build Stage
FROM maven:3.9.6-eclipse-temurin-17 AS build


# Build Stage
WORKDIR /opt/app

COPY ./ /opt/app
RUN mvn clean install -DskipTests


# Docker Build Stage
FROM openjdk:17-alpine

COPY --from=build /opt/app/target/*.jar app.jar

ENV PORT 8008
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Xmx1024M","-Dserver.port=${PORT}","app.jar"]

