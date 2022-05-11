pipeline {
    agent {
        dockerfile {
            additionalBuildArgs '--no-cache'
        }
    }
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
                        image_id = sh (script: "docker images -q $IMAGE_NAME:$IMAGE_TAG", returnStdout: true).trim()
                        return image_id.isEmpty()
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
        }
        stages {
            stage('Build Docker image') {
                steps {
                    sh '''
                        cp Dockerfile Dockerfile
                        docker build --no-cache --pull -t $IMAGE_NAME .
                        docker tag $IMAGE_NAME $IMAGE_NAME:$IMAGE_TAG
                    '''
                }
            }
        }
        stages {
            agent {
                docker {
                    $IMAGE_NAME:$IMAGE_TAG
                }
            }
            stage ('Restore environment') {
                steps {
                    sh '''
                        R --vanilla -e "renv::activate()"
                        R -e "renv::restore()"
                    '''
                }
            }
            stage('Testing and Deployment') {
                stages {
                    stage('Syntax Check') {
                        steps {
                            echo "Testing Syntax..."
                            catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
                                sh '''
                                    Rscript dev/run-lintr.R
                                '''
                            }
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