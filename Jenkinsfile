pipeline {
    agent {
        dockerfile true
    }
    options {
        // disableConcurrentBuilds()
        timestamps()
        timeout(time: 2, unit: 'HOURS')
    }
    stages {
        stage ('First step') {
            steps  {
                echo 'Hello...'
            }
        }
    }

}