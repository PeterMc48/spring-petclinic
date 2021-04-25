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
        
        stage('Deploy Docker Image To EC2 Instance')
        {​​​​​​​
            steps
            {​​​​​​​
                script
                {​​​​​​​
                    def deploy = "docker run --publish 80:8080 -d --name petclinic mccaffertydocker/petclinic:2.0.0"
                    def stop = "docker stop petclinic || true"
                    def remove = "docker rm petclinic || true"
                    def instance = "ec2-user@ec2-52-7-235-115.compute-1.amazonaws.com"
                    sshagent(['EC2UserID']) 
                    {
                        sh "ssh -T -o StrictHostKeyChecking=no ${​​​​​​​instance}​​​​​​​ ${​​​​​​​stop}​​​​​​​"
                        sh "ssh -T -o StrictHostKeyChecking=no ${​​​​​​​instance}​​​​​​​ ${​​​​​​​remove}​​​​​​​"
                        sh "ssh -T -o StrictHostKeyChecking=no ${​​​​​​​instance}​​​​​​​ ${​​​​​​​deploy}​​​​​​​"
                    }
                }​​​​​​​
            }​​​​​​​
        }​​​​​​​


    }
}