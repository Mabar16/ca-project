pipeline {
  agent any
  stages {
    stage('Stash') {
      steps {
        stash(excludes: '.git', name: 'Code')
      }
    }

    stage('Run App') {
      steps {
        sh '''apt-get update -y
apt-get install python3-pip -y
pip3 install flask
python run.py'''
      }
    }

  }
}