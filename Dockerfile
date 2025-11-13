FROM maven:3.8.7-jdk-17 AS build 
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean install -DskipTests


FROM amazoncorretto:17-alpine
WORKDIR /app

COPY --from=build /app/target/ic_dc-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]