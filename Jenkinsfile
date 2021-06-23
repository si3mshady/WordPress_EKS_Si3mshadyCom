job('Wordpress EKS Deployment' ) {
    
   description('Wordpress EKS ')

   scm {
            git('https://github.com/si3mshady/WordPress_EKS_Si3mshadyCom', 'main')
        }
    
    
    steps {       

        shell('''
            python3 -m venv si3mshady || true && echo "venv si3mshady already created"
            source si3mshady/bin/activate
            curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
            python get-pip.py || true && python3 get-pip.py
            pip install awscli || true && pip3 awscli
        ''')
    }

    
}
