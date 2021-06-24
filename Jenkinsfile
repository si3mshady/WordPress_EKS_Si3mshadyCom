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


            kubectl -n kube-system get cm

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
         

            kubectl apply -f ./wp_storage_class.yml --namespace=eks-wordpress-si3mshady \
            || true && echo "storage class already exists"

            kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' \
              --namespace=eks-wordpress-si3mshady  || true && echo "patch job has already be created"

              kubectl apply -f ./persistent_volume_claim.yml --namespace=eks-wordpress-si3mshady \
               || true && echo "pvc has already been created"

              kubectl create secret generic mysql-pass --from-literal=password=12345678 --namespace=eks-wordpress-si3mshady \
              || true && echo "generic password has already been created"

              kubectl apply -f ./mysql_deployment.yml --namespace=eks-wordpress-si3mshady \
              || true && echo "mysql pod and service are already deployed"

              kubectl apply -f ./wordpress_deployment.yml --namespace=eks-wordpress-si3mshady \
              || true && echo "wordpress pod and service have already been deployed"

              kubectl get services --namespace=eks-wordpress-si3mshady || true kubectl get svc --namespace=eks-wordpress-si3mshady      


              echo $PWD
              which kubectl 
              whereis kubectl 
              whoami 

        ''')

        
    }

    
}


