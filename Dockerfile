FROM maven:3.9.6-eclipse-temurin-17 AS build

# compile and build jar
WORKDIR /app
COPY ./ /app
RUN mvn clean package

# Build Stage
FROM openjdk:17-jdk-alpine
EXPOSE 8008
# publish image from jar
ARG JAR_FILE=/app/target/demo-deployment.jar
COPY --from=build ${JAR_FILE} app.jar
ENTRYPOINT ["java","-jar","/app.jar"]