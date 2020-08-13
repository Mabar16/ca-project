pipeline {
  agent any
  stages {
    stage('Hello World') {
      steps {
        stash(excludes: '.git', name: 'Code')
      }
    }

  }
}