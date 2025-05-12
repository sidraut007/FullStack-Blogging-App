# DEVELOPMENT Stage Building Artifact
# Import docker image with maven installed
FROM maven:3.8.3-openjdk-17 as builder 

LABEL app=blogging-app

WORKDIR /src

COPY . /src

RUN mvn clean install -DskipTests=true

# PRODUCTION Stage  
FROM eclipse-temurin:17-jdk-alpine

# Copy build from stage 1 (builder)
COPY --from=builder /src/target/*.jar /src/target/blog.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/src/target/blog.jar"]