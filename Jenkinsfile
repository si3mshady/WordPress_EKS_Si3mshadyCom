pipeline {
    agent any 
    stages {        
           stage('Build-EKS') { 
            steps {            
                sh 'python3 -m venv si3mshady || true echo "venv si3mshady already created"'
                sh 'source si3mshady/bin/activate'            
                sh 'curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py'
                sh 'python get-pip.py || true python3 get-pip.py'
                sh 'pip install awscli || true pip3 awscli'                                           
                
            }
        }



        stage('Test') { 
            steps {
                // 
            }
        }
        stage('Deploy') { 
            steps {
                // 
            }
        }
    }
}