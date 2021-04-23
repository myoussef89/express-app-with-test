node {    
      def app     
      stage('Clone repository') {               
             
		steps {
			git([url: 'git@github.com:myoussef89/express-app-with-test.git', branch: 'develop', credentialsId: 'myoussef89'])

		  }    
      }     
      stage('Build image') {         
       
            app = docker.build("greentube/test")
       }     
      stage('Test image') {
            app.inside {            
             
             sh 'npm run test'        
            }    
        }     
       stage('Push image') {
		docker.withRegistry('https://registry.hub.docker.com', 'joe-docker-hub') {
		   app.push("${env.BUILD_NUMBER}")            
		   app.push("latest")        
              }    
           }
}
