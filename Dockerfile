FROM maven:3.6.0-jdk-13-alpine AS build
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package -DskipTests


FROM openjdk:13-alpine
WORKDIR /app
COPY --from=build /app/target/GreenHouse-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8088
ENTRYPOINT ["java","-jar","app.jar"]