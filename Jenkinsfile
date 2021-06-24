job('Wordpress EKS Deployment' ) {
    
   description('Wordpress EKS')

   scm {
            git('https://github.com/si3mshady/WordPress_EKS_Si3mshadyCom', 'main')
        }
    
    
    steps {       
        
        shell('''                

            echo "install pip & aws-cli"         
            apt-get install python3-pip -y || true && echo 'Python3-pip is installed'
            apt-get install -y  curl || true && echo 'Curl already installed'                      
            curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
            python get-pip.py || true && python3 get-pip.py
            pip install awscli || true && pip3 install awscli
        ''')

        shell('''
            echo "install eksctl"  
            curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | \\
            tar xz -C /tmp  
            mv /tmp/eksctl /usr/local/bin
            eksctl create cluster -f  base-wordpress-cluster.yml &&  \
            kubectl -n kube-system get configmap aws-auth -o yaml > aws-auth-configmap.yaml || true && echo "cluster is already deployed."         
            
           

            

        ''')

        

        
    }

    
}


