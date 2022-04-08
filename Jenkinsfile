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
    stages {
        stage('Checkout') {
            steps {
                echo 'Checking out repo...'
                checkout scm
            }
        }
        stage ('Restore environment') {
            steps {
                sh '''
                    R --vanilla -e "renv::restore()"
                '''
            }
        }
        stage('Testing and Deployment') {
            stages {
                stage('Syntax Check') {
                    steps {
                        script {
                            try {
                                echo "Testing Syntax..."
                                sh '''
                                    Rscript dev/run-lintr.R
                                '''
                            }
                            catch(Exception e) {
                                echo "Syntax checking failed!"
                                currentBuild.result = 'UNSTABLE'
                            }
                        }
                    }
                }
                stage('Testing') {
                    steps {
                        echo "Running Tests"
                        which R
                        sh '''
                            R --vanilla -e "shiny::runTests()"
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