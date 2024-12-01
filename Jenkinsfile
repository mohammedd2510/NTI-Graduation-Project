pipeline {
  agent {
   docker {
      image 'mosama25/dynamic_jenkins_agent:v1.0'
      args '--user root -v /var/run/docker.sock:/var/run/docker.sock' // mount Docker socket to access the host's Docker daemon
    }
  }
    environment {
        DOCKER_FRONTEND_IMAGE = "public.ecr.aws/i5a7b8h3/nti-project-frontend:v${BUILD_NUMBER}.0"
        ECR_NAME ="public.ecr.aws/i5a7b8h3/nti-project-frontend"
        DOCKER_LOGIN_CREDS = credentials('docker_credentials')// Replace with your Jenkins credentials ID
        GITHUB_CREDS = credentials('github')
        GITHUB_REPO = "NTI-Graduation-Project"
        GITHUB_BRANCH = "feature/frontend"
        DEPLOYMENT_FILE = "project-manifests/frontend_deployment.yml"
        WEBHOOK_ID ="516307081"
    }

  stages {
    stage('Disable Webhook') {
    steps {
        script {
            sh '''
            curl -X PATCH -H "Authorization: token $GITHUB_CREDS_PSW" \
            https://api.github.com/repos/$GITHUB_CREDS_USR/$GITHUB_REPO/hooks/$WEBHOOK_ID \
            -d '{"active": false}'
            '''
        }
    }
}
    stage('Checkout') {
      steps {
        echo 'fetching repo'
        git branch: "${GITHUB_BRANCH}", url: "https://github.com/mohammedd2510/${GITHUB_REPO}.git"
      }
    }
     stage('Build Docker Images') {
            steps {
                echo 'Building Docker image...'
                sh '''
                docker build -t $DOCKER_FRONTEND_IMAGE ./frontend
                '''
            }
        }
        stage('Login to Docker Hub') {
            steps {
                echo 'Logging into Docker Hub...'
                sh '''
                    echo "$DOCKER_LOGIN_CREDS_PSW" | docker login -u $DOCKER_LOGIN_CREDS_USR --password-stdin public.ecr.aws/i5a7b8h3
                    
                '''
            }
        }
        stage('Push Docker Images') {
            steps {
                echo 'Pushing Docker image...'
                sh '''
                docker push $DOCKER_FRONTEND_IMAGE
                '''
            }
        }
      stage('Update Deployment File') {
         steps {
            withCredentials([gitUsernamePassword(credentialsId: 'github', gitToolName: 'Default')]) {
                sh '''
                    BUILD_NUMBER=${BUILD_NUMBER}
                    sed -i "s|\\(image: $ECR_NAME:\\)[^ ]*|\\1v${BUILD_NUMBER}.0|g" $DEPLOYMENT_FILE
                    git config --global --add safe.directory $WORKSPACE
                    git add ./$DEPLOYMENT_FILE
                    git commit -m "Update Frontend deployment image to version ${BUILD_NUMBER}"
                    git push origin ${GITHUB_BRANCH}
                '''
            }
        }
    }
 stage('Make Git Pull Request'){
        steps{
            sh '''
            curl -X POST \
                -H "Authorization: token $GITHUB_CREDS_PSW" \
                -H "Accept: application/vnd.github.v3+json" \
                -d '{"title":"Frontend new feature","body":"Please pull this in!","head":"'"${GITHUB_BRANCH}"'","base":"main"}' \
                     https://api.github.com/repos/$GITHUB_CREDS_USR/$GITHUB_REPO/pulls
            '''
        }
    }
    stage('Enable Webhook') {
    steps {
        script {
            sh '''
            curl -X PATCH -H "Authorization: token $GITHUB_CREDS_PSW" \
            https://api.github.com/repos/$GITHUB_CREDS_USR/$GITHUB_REPO/hooks/$WEBHOOK_ID \
            -d '{"active": true}'
            '''
        }
    }
}
   
  }
 post {
        success {
            script {        
                def jobNameDecoded = java.net.URLDecoder.decode(env.JOB_NAME, "UTF-8")
                slackSend(
                    color: 'good', 
                    message: ":white_check_mark:*Build Successful*\nJob_Name: ${jobNameDecoded}\nBuild_Number: #${BUILD_NUMBER}\nStatus: Frontend Image is built successfully and a Pull Request is created\nMore info at: ${BUILD_URL}.",
                    channel: '#nti-graduation-project'
                )
        }
        }

        failure {
            script {
                def jobNameDecoded = java.net.URLDecoder.decode(env.JOB_NAME, "UTF-8")
                slackSend(
                    color: 'danger', 
                    message: ":x:*Build Failed*\nJob_Name: ${jobNameDecoded}\nBuild_Number: #${BUILD_NUMBER}\nStatus: Build Failed.\nMore info at: ${BUILD_URL}",
                    channel: '#nti-graduation-project'
                )
        }
        }
    }
}
