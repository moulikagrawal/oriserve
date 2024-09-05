pipeline {
    agent any
    environment {
        AWS_DEPLOYMENT_GROUP = 'Ori_Jenkins_Deploy'
        AWS_APPLICATION_NAME = 'Oriserve'
        S3_BUCKET = 'oriserve-package'
        S3_KEY = 'oriserve.zip'
        REGION = 'ap-south-1'
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/moulikagrawal/oriserve.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    // Build steps (e.g., npm install, mvn package, etc.)
                    echo ("Building")
                }
            }
        }
        stage('Package') {
            steps {
                script {
                    // Package the application into a ZIP file
                    sh 'zip -r oriserve.zip .'
                }
            }
        }
        stage('Upload to S3') {
            steps {
                script {
                    // Upload the ZIP file to S3
                    sh "aws s3 cp oriserve.zip s3://${S3_BUCKET}/${S3_KEY} --region ${REGION}"
                }
            }
        }
        stage('Deploy to EC2') {
            steps {
                script {
                    // Deploy using CodeDeploy
                    sh """
                    aws deploy create-deployment \
                    --application-name ${AWS_APPLICATION_NAME} \
                    --deployment-group-name ${AWS_DEPLOYMENT_GROUP} \
                    --s3-location bucket=${S3_BUCKET},key=${S3_KEY},bundleType=zip \
                    --region ${REGION}
                    """
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}