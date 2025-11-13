# ETAPA 1: BUILD - Usamos la etiqueta genérica y estable "3-jdk-17".
# Esto le dice a Docker que use la última versión de Maven 3.x con JDK 17.
FROM maven:3-jdk-17 AS build 
WORKDIR /app
COPY pom.xml .
COPY src /app/src
RUN mvn clean install -DskipTests

# ETAPA 2: RUNTIME - Imagen ligera basada en Amazon Corretto (mantenida por AWS)
# Esta etiqueta funcionó bien en la última prueba donde falló la etapa BUILD.
FROM amazoncorretto:17-alpine
WORKDIR /app
COPY --from=build /app/target/ic_dc-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]