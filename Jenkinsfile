pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub-cred-raja')
	}

	stages {

		stage('Build-Image') {
			//Building and tagging our Docker image
			//rename the user name michaelgwei86 with the username of your dockerhub repo
			steps {
				sh 'docker build -t michaelgwei86/effulgencetech-nodejs-image:v1.0 .'
				sh 'docker images'
			}
		}

		stage('Login to Dockerhub') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Build-Container') {
			//Building and tagging our Docker container
			//rename the user name michaelgwei86 with the username of your dockerhub repo
			steps {
				sh 'docker run --name effulgencetech-nodejs-cont -p 80:8080 -d michaelgwei86/effulgencetech-nodejs-image:v1.0'
				sh 'docker ps'
			}
		}


		stage('Push-image') {
			//Pushing image to dockerhub
			steps {
				sh 'docker push michaelgwei86/nodejs-image-effulgencetech:latest'
			}
		}
	}

    post { 
        always { 
            echo 'I will always say Hello again!'
            slackSend channel: '#effulgencetech-devops-channel', color: COLOR_MAP[currentBuild.currentResult], message: "*${currentBuild.currentResult}:*, Job ${env.JOB_NAME} build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
        }
    }

}