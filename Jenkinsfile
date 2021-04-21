pipeline{
    agent any
    stages{
        stage("build"){
            steps{
                bat "C:/DevOps/apache-maven-3.8.1/bin/mvn -version"
                bat "mvn clean package"
            }
        }
        stage("test"){
            steps{
                bat "mvn test"
                junit "**/target/surefire-reports/TEST-*.xml"
            }
        }
    }
}