pipeline {
    agent any
    stages {
    
        stage('Clone repository') {
            steps {
                checkout scm
            }   
        }
        
        stage('Build image') {
            steps {
                script {
                    def app
                    app = docker.build("memo600/greentube")
                }   
            }   
        }
        
      stage('Test image') {
        steps {
            script {
                app.inside {

                //sh 'npm install'
                sh 'npm test'
                }
            } 
        }       
      }
      
      stage ('publish report') {
        steps {
          publishHTML (target: [
            allowMissing: false,
            alwaysLinkToLastBuild: false,
            keepAll: true,
            reportDir: 'coverage/lcov-report',
            reportFiles: 'index.html',
            reportName: "Express Report"
          ])
        } 
       }
       
        stage('Push image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'joe-docker-hub') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
                }
            }   
        }
    }      
}

