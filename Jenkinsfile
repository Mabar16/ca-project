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
apt-get install pip -y
pip install flask
python run.py'''
      }
    }

  }
}