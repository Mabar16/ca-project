pipeline {
  agent any
  stages {
    stage('Stash') {
      steps {
        stash(excludes: '.git', name: 'Code')
      }
    }

    stage('Setup') {
      steps {
        sh '''apt-get update -y
apt-get install python3-pip -y
pip3 install -r requirements.txt'''
      }
    }

    stage('Test') {
      steps {
        sh 'python3 tests.py'
      }
    }

    stage('Parallel Execution') {
      parallel {
        stage('Push Docker app') {
          agent any
          when {
            branch 'master'
          }
          environment {
            DOCKERCREDS = credentials('docker_login')
          }
          steps {
            unstash 'Code'
            sh '''chmod u+r+x docker-build.sh
./docker-build.sh'''
            sh 'echo "$DOCKERCREDS_PSW" | docker login -u "$DOCKERCREDS_USR" --password-stdin'
            sh './docker-push.sh'
          }
        }

        stage('Compress and Archive') {
          steps {
            sh '''mkdir ./artifacts/
tar -zcvf ./artifacts/flaskapp.tar.gz .'''
            archiveArtifacts 'artifacts/'
            stash(name: 'Code', excludes: '.git')
          }
        }

      }
    }

    stage('Deploy') {
      steps {
        sh 'echo \'deploy\''
      }
    }

  }
  environment {
    docker_username = 'mabar16'
  }
}