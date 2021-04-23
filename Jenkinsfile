pipeline{
    agent any

    tools{
        maven "Maven 3.8.1"
        jdk "Java SE 9.0.4"
    }
    stages{
        stage("build")
        {
            steps
            {
                bat "mvn -version"
                bat "mvn clean package"
            }
        }
        stage("test")
        {
            parallel
            {
                stage('junit')
                {
                    steps
                    {
                        bat "mvn test"
                        junit "**/target/surefire-reports/TEST-*.xml"
                    }
                }
                stage('sonar')
                {
                    steps
                    {
                        withSonarQubeEnv('SonarQube')
                        {
                            bat "mvn -Dsonar.qualitygate=true sonar:sonar"
                        }
                    }
                }
                
            }
            
        }
    }
}