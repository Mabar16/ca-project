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
        stage('Run') {
          steps {
            sh 'python3 run.py &'
          }
        }

        stage('Compress and Archive') {
          steps {
            sh 'tar -zcvf ./artifacts/flaskapp.tar.gz .'
            archiveArtifacts 'artifacts/'
            stash(name: 'Code', excludes: '.git')
          }
        }

      }
    }

  }
}