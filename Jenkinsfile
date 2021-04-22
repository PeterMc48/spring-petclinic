pipeline{
    agent any

    tools{
        maven "Maven 3.8.1"
    }
    stages{
        stage("build"){
            steps{
                bat "mvn -version"
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