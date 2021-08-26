#FROM maven:3.6-jdk-12-alpine as build
FROM maven:3.6.3-jdk-11-slim as build


WORKDIR /app
COPY pom.xml .
COPY src src

RUN mvn package && \
jlink --add-modules java.base,java.compiler,java.instrument,java.naming,java.rmi,java.security.jgss,java.security.sasl,java.sql,jdk.jconsole,jdk.unsupported \
--compress 2 --no-header-files --no-man-pages --output target/runtime-image

#FROM alpine:3.8
FROM debian:stretch-slim as release

COPY --from=build /app/target/runtime-image /app

COPY --from=build /app/target/spring-boot-todo-app-2.2.0-SNAPSHOT.jar \
                  /app/spring-boot-todo-app.jar

ENTRYPOINT ["/app/bin/java", "-jar"]
CMD ["/app/spring-boot-todo-app.jar"]
