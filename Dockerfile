# ETAPA 1: BUILD - Usamos la imagen oficial de Maven con JDK 17 (Esta ya funciona!)
FROM maven:3.8-jdk-17 AS build 
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean install -DskipTests

# ETAPA 2: RUNTIME - Crea la imagen final ligera
# Usaremos "amazoncorretto:17-alpine" que es una imagen oficial de Amazon y muy estable.
FROM amazoncorretto:17-alpine
WORKDIR /app
COPY --from=build /app/target/ic_dc-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]