FROM anapsix/alpine-java
COPY /target/*.jar /spring-petclinic-2.2.0.jar
CMD ["java","-jar","/spring-petclinic-2.2.0.jar"]