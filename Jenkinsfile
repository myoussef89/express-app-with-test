node {    
      def app     
      stage('Clone repository') {               
	    checkout scm
      }     
      stage('Build image') {         
       
            app = docker.build("greentube/test")
       }     
      stage('Test image') {
            app.withRun { c ->            
             
             sh 'npm test'        
            }    
        }     
       stage('Push image') {
		docker.withRegistry('https://registry.hub.docker.com', 'joe-docker-hub') {
		   app.push("${env.BUILD_NUMBER}")            
		   app.push("latest")        
              }    
           }
}
