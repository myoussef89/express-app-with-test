node {    
      def app     
      stage('Clone repository') {               
	    checkout scm
	    //git([url: 'git@github.com:myoussef89/express-app-with-test.git', branch: 'develop', credentialsId: 'myoussef89'])
      }     
      stage('Build image') {         
       
            app = docker.build("greentube/test")
       }     
      stage('Test image') {
            app.inside {            
             
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
