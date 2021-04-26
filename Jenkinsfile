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
                      docker.build("memo600/greentube","--target dev -f Dockerfile .")
                  }   
              }   
            }
            
          stage('Test image') {
            steps {
                script {
                    docker.image("memo600/greentube").inside {

                    sh 'npm install'
                    sh 'npm test'
                    sh 'npm run test:e2e'
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
                when {
                  branch 'master'
                }           
                steps {
                    script {
                        docker.withRegistry('https://registry.hub.docker.com', 'joe-docker-hub') {
                        docker.image("memo600/greentube").push("${env.BUILD_NUMBER}")
                        docker.image("memo600/greentube").push("latest")
                        }
                    }
                }   
            }
        }
        
      post {
        success {

          emailext (
              subject: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
              body: """SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'
                Check console output at '${env.BUILD_URL}'""",
              recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
        }

        failure {

          emailext (
              subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
              body: """FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'
                Check console output at '${env.BUILD_URL}'""",
              recipientProviders: [[$class: 'DevelopersRecipientProvider']]
            )
        }
      } 
}

