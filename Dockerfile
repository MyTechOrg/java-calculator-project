#Stage 1: Build the application using maven
FROM maven:3.9-eclipse-temurin-17 as build

#Copy the project configuration and source code
COPY pom.xml .
COPY src ./src

#Compile and run unit tests, then package the application
RUN mvn clean package

#Stage 2: Create a lightweight runtime image
FROM eclipse-temurin: 17-jre-alpine
WORKDIR /app

#Copy the compiled jar from the build stage
COPY --from=build /app/target/java-calculator-1.0-SNAPSHOT.jar /app/calculator.jar

#Set the default command to execute the application (or run tests/jar)
ENTRYPOINT ["java", "-jar", "/app/calculator.jar"]

