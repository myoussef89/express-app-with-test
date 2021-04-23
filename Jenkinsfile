node {    
      def app     
      stage('Clone repository') {               
	    checkout scm
      }     
      stage('Build image') {         
       
            app = docker.build("greentube/test")
       }     
      stage('Test image') {
            app.inside {          
             
             //sh 'npm install'
	     sh 'npm test'
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
		docker.withRegistry('https://registry.hub.docker.com', 'joe-docker-hub') {
		   app.push("${env.BUILD_NUMBER}")            
		   app.push("latest")        
              }    
           }
}
