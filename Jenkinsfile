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
        sh 'python run.py'
      }
    }

  }
}