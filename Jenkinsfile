pipeline {
    agent any
    stages {
    
        stage('Clone repository') {
            checkout scm
        }
        
        stage('Build image') {
            script {
                def app
                app = docker.build("memo600/greentube")
            }   
        }
        
      stage('Test image') {
        script {
            app.inside {

             //sh 'npm install'
             sh 'npm test'
            }
        }   
      }
       stage ('publish report') {
         publishHTML (target: [
          allowMissing: false,
          alwaysLinkToLastBuild: false,
          keepAll: true,
          reportDir: 'coverage/lcov-report',
          reportFiles: 'index.html',
          reportName: "Express Report"
         ])
       }
        stage('Push image') {
            script {
                    docker.withRegistry('https://registry.hub.docker.com', 'joe-docker-hub') {
                    app.push("${env.BUILD_NUMBER}")
                    app.push("latest")
                    }
            }
        }
    }      
}

