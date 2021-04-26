pipeline
{
    agent any

    tools
    {
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
        stage("Build Docker Image")
        {
            steps
            {
                bat 'docker build -t mccaffertydocker/petclinic:2.0.0 .'
            }
        }
        stage("Push Docker Image")
        {
            steps
            {
                withCredentials([string(credentialsId: 'dockerhubpassword', variable: 'Dockerhubpassword')]) 
                {
                     bat "docker login -u mccaffertydocker -p ${Dockerhubpassword}"
                }
                     bat 'docker push mccaffertydocker/petclinic:2.0.0'
            }
        }
        stage("Deploy to EC2")
        {
            steps
            {
                sshagent(['EC2FileID']) {
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@52.201.236.125 docker stop petclinic || true"
                    sh "ssh -o StrictHostKeyChecking=no ec2-user@52.201.236.125 docker rm petclinic || true"           

                    sh "ssh -o StrictHostKeyChecking=no ec2-user@52.201.236.125 docker run -p 8080:8080 -d --name petclinic mccaffertydocker/petclinic:2.0.0"
                } 
            }
        }
        
    }
}