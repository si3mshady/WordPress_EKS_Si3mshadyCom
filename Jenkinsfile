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

            #https://github.com/weaveworks/eksctl/issues/1979
            #https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html
            
            instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)

            aws ec2 modify-instance-metadata-options \
            --instance-id $instance_id \
            --http-put-response-hop-limit 2 \
            --http-endpoint enabled
            eksctl create cluster -f  base-wordpress-cluster.yml  || true && echo "cluster is already deployed."         
        ''')

         shell('''        
            echo "create wordPress deployment"                     
            kubectl create namespace eks-wordpress-si3mshady  || true && echo "namespace eks-wordpress-si3mshady exists."     
            echo "creating storage class"

            kubectl apply -f wp_storage_class.yml --namespace=eks-wordpress-si3mshady 

            kubectl patch storageclass gp2 -p \
            
             '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' \
              --namespace=eks-wordpress-si3mshady
        ''')

        
    }

    
}


