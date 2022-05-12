pipeline {
    agent { dockerfile true }
    options {
        // disableConcurrentBuilds()
        timestamps()
        timeout(time: 2, unit: 'HOURS')
    }
    environment {
        IMAGE_TAG = 'LATEST'
        IMAGE_NAME = 'SHINY_TEMPLATE'
    }
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out repo...'
                checkout scm
            }
        }
        stage('Create Docker image') {
            when {
                anyOf {
                    expression {
                        cmd = "bash -c '(docker inspect ${image_id} > /dev/null 2>&1 && echo found) || echo notfound'"
                        found = sh([returnStdout: true, script: cmd]).trim()
                        if (found == 'found') {
                            return true
                        }
                        return false
                    }
                    allOf {
                        branch 'master'
                        anyOf {
                            changeset "renv.lock"
                            changeset "Dockerfile"
                        }
                    }
                }
            }
            steps {
                sh '''
                    cp Dockerfile Dockerfile
                    docker build --no-cache -t $IMAGE_NAME:$IMAGE_TAG .
                '''
            }
        }
        stage('Testing and deployment') {
            agent {
                docker { image $IMAGE_NAME:$IMAGE_TAG }
            }
            stages {
                stage('Restore environment') {
                    steps {
                        sh '''
                            R --vanilla -e "renv::activate()"
                            R -e "renv::restore()"
                        '''
                    }
                }
                stage('Testing') {
                    steps {
                        echo "Running Tests"
                        sh '''
                            R -e "shiny::runTests()"
                        '''
                    }
                }
                stage('Deployment') {
                    when {
                        anyOf { branch 'develop'; branch 'master'; }
                    }
                    environment {
                        DEPLOYMENT_ENV = sh(returnStdout: true, script: 'if [[ $ENV == "master" ]]; then echo "prd"; else  echo "dev"; fi')
                    }
                    steps {
                        echo "DEPLOYMENT ENVIRONMENT: ${DEPLOYMENT_ENV}"
                        echo "BRANCH_NAME: ${env.BRANCH_NAME}"
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
            deleteDir()
        }
        success {
            echo 'SUCCESS'
        }
        unstable {
            echo 'UNSTABLE'
        }
        failure {
            echo 'FAILURE'
        }
        changed {
            echo 'CHANGED'
        }
    }
}