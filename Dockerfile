FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app

COPY pom.xml .
# Copia el código fuente
COPY src /app/src
# Compila el proyecto, omitiendo pruebas
RUN mvn clean install -DskipTests

# Crea la imagen final ligera con OpenJDK Alpine
FROM openjdk:17-jdk-alpine
WORKDIR /app
# Copia el JAR compilado desde la etapa 'build'
COPY --from=build /app/target/ic_dc-0.0.1-SNAPSHOT.jar app.jar
# Expone el puerto por defecto de Spring Boot
EXPOSE 8080
# Comando para iniciar la aplicación
CMD ["java", "-jar", "app.jar"]