pipeline{
    agent any
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