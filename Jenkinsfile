
def buildNumber = env.BUILD_NUMBER

pipeline{

	agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('DOCKERHUB_CREDENTIALS')
	}

	stages {

		stage('Build-Image') {
			//Building and tagging our Docker image
			//rename the user name michaelgwei86 with the username of your dockerhub repo
			steps {
				sh 'docker build -t michaelgwei86/effulgencetech-nodejs-image:$buildNumber .'
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
				sh 'docker run --name effulgencetech-node-cont:$buildNumber -p 8081:8081 -d michaelgwei86/effulgencetech-nodejs-image:+$(env.BUILD_NUMBER)'
				sh 'docker ps'
			}
		}


		stage('Push-image') {
			//Pushing image to dockerhub
			steps {
				sh 'docker push michaelgwei86/effulgencetech-nodejs-image:v1.0'
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