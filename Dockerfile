# ETAPA 1: BUILD - Usamos la imagen oficial de Maven con JDK 17
# Usamos la etiqueta "3.8-jdk-17" para una compatibilidad más amplia
FROM maven:3.8-jdk-17 AS build 
WORKDIR /app

# Copia los archivos de configuración y el código fuente
COPY pom.xml .
COPY src /app/src

# Compila el proyecto Spring Boot, omitiendo pruebas
RUN mvn clean install -DskipTests

# ETAPA 2: RUNTIME - Crea la imagen final ligera
# Usamos "17-alpine" que es estándar para OpenJDK en Alpine Linux
FROM openjdk:17-alpine
WORKDIR /app

# Copia el JAR compilado desde la etapa 'build'
COPY --from=build /app/target/ic_dc-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8080
CMD ["java", "-jar", "app.jar"]