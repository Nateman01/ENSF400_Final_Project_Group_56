# Build application
FROM gradle:7.6.1-jdk11 AS build
WORKDIR /demo
COPY . .
RUN ./gradlew clean build

# Create smaller image with Tomcat
FROM tomcat:9.0-jdk11-openjdk-slim
WORKDIR /usr/local/tomcat/webapps/
COPY --from=build /demo/build/libs/*.war /usr/local/tomcat/webapps/demo.war
EXPOSE 8080
CMD ["catalina.sh", "run"]