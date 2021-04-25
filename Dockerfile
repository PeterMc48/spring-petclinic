FROM openjdk:11
ADD target/spring-petclinic-2.4.2.jar spring-petclinic-2.4.2.jar
ENTRYPOINT ["java", "-jar", "/spring-petclinic-2.4.2.jar"]