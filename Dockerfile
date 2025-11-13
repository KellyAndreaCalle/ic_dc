# ETAPA 1: BUILD - Usamos una imagen base estable de Amazon Corretto JDK 17
# Luego, instalamos Maven manualmente para asegurar el build.
FROM amazoncorretto:17-alpine AS build 
WORKDIR /app

# Instalar Maven (usando el gestor de paquetes de Alpine)
RUN apk add --no-cache maven

# Copia los archivos del proyecto
COPY pom.xml .
COPY src /app/src

# Compila el proyecto Spring Boot
RUN mvn clean package -DskipTests

# ETAPA 2: RUNTIME - Imagen ligera basada en Amazon Corretto
# Mantenemos esta ya que es la más estable para el entorno AWS
FROM amazoncorretto:17-alpine
WORKDIR /app

# Copia el JAR compilado desde la etapa 'build'
COPY --from=build /app/target/ic_dc-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]