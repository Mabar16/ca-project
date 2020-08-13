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
        unstash 'Code'
        sh '''apt-get update -y
apt-get install python3-pip -y
pip3 install -r requirements.txt'''
        skipDefaultCheckout true
      }
    }

    stage('Test') {
      steps {
        unstash 'Code'
        sh 'python3 tests.py'
        skipDefaultCheckout true
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
            skipDefaultCheckout true
          }
        }

        stage('Compress and Archive') {
          steps {
            unstash 'Code'
            sh '''mkdir ./artifacts/
mkdir tmp
cp *.py ./tmp/
tar -zcvf ./artifacts/flaskapp.tar.gz --no-wildcards \'tmp/\' \'app/\' \'db_repository/\' --exclude=\'./tmp/tests.py\''''
            archiveArtifacts 'artifacts/'
            stash(name: 'Code', excludes: '.git')
            skipDefaultCheckout true
          }
        }

      }
    }

    stage('Deploy') {
      steps {
        unstash 'Code'
        skipDefaultCheckout true
        sshagent(credentials: ['server_ssh_key']) {
          sh 'ssh -o StrictHostKeyChecking=no ubuntu@35.233.9.52 docker run -d mabar16/flaskapp:latest'
        }

      }
    }

  }
  environment {
    docker_username = 'mabar16'
  }
}