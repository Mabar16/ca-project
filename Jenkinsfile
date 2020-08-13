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

    stage('Run') {
      steps {
        sh 'python3 run.py &'
      }
    }

  }
}