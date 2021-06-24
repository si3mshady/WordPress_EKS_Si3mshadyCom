job('Wordpress EKS Deployment' ) {
    
   description('Wordpress EKS')

   scm {
            git('https://github.com/si3mshady/WordPress_EKS_Si3mshadyCom', 'main')
        }
    
    
    steps {       
        
        shell('''                            
            apt-get update &&  apt-get install -y apt-transport-https
            curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg |  apt-key add -
            apt-get update
            echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
            apt-get install -y kubectl
                
            apt-get install python3-pip -y || true && echo 'Python3-pip is installed'
            apt-get install -y  curl || true && echo 'Curl already installed'                      
            curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
            python get-pip.py || true && python3 get-pip.py
            pip install awscli || true && pip3 install awscli           
        ''')

        shell('''
            echo "install eksctl"  
            curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | \
            tar xz -C /tmp  
            mv /tmp/eksctl /usr/local/bin      
            #https://github.com/weaveworks/eksctl/issues/1979
            #https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html
            
            instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)

            aws ec2 modify-instance-metadata-options \
            --instance-id $instance_id \
            --http-put-response-hop-limit 2 \
            --http-endpoint enabled \
            --region us-east-1 

            eksctl create cluster -f  base-wordpress-cluster.yml || true && echo 'pass' && \\                     
        
            kubectl create namespace eks-wordpress-si3mshady || true   && echo 'pass'  && \\ 

            kubectl apply -f ./wp_storage_class.yml --namespace=eks-wordpress-si3mshady || true  && echo 'pass' && \\

            kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' \\
            --namespace=eks-wordpress-si3mshady  || true  && echo 'pass' && \\
                         
            kubectl apply -f ./persistent_volume_claim.yml --namespace=eks-wordpress-si3mshady || true && echo 'pass' && \\

            kubectl create secret generic mysql-pass --from-literal=password=12345678 --namespace=eks-wordpress-si3mshady || true && echo 'pass' && \\
            
            kubectl apply -f ./mysql_deployment.yml --namespace=eks-wordpress-si3mshady || true && echo 'pass'  && \\    
            kubectl apply -f ./mysql_deployment.yml --namespace=eks-wordpress-si3mshady || true && echo 'pass' && \\    

            kubectl apply -f ./wordpress_deployment.yml --namespace=eks-wordpress-si3mshady || true && echo 'pass' && \\                        

            namespace=$(kubectl get ns | grep -i si3ms |  awk '{print $1}') || true  && echo 'pass' && \\ 
            loadBalancerURL=$(kubectl get svc --namespace=$namespace | grep LoadBalancer | awk '{print $4}') || true && echo 'pass' && \\

            sed -i 's/"a.example.com"/"service.si3mshady.com"/g' CNAME.json || true && echo 'pass'  && \\
            sed -i 's/"8.8.8.8"/"\$loadBalancerURL"/g' CNAME.json  || true && echo 'pass'  && \\

            aws route53 change-resource-record-sets \\
            --hosted-zone-id Z099267523KVY5EITOQ5W \\
            --change-batch file://CNAME.json        
        ''')

         
        shell('''  

            eksctl create cluster -f  base-wordpress-cluster*dev.yml || true && echo 'pass' && \\                     
        
            kubectl create namespace eks-wordpress-si3mshady || true   && echo 'pass'  && \\ 

            kubectl apply -f ./wp_storage_class*dev.yml --namespace=eks-wordpress-si3mshady || true  && echo 'pass' && \\

            kubectl patch storageclass gp2 -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}' \\
            --namespace=eks-wordpress-si3mshady  || true  && echo 'pass' && \\
                         
            kubectl apply -f ./persistent_volume_claim*dev.yml --namespace=eks-wordpress-si3mshady || true && echo 'pass' && \\

            kubectl create secret generic mysql-pass --from-literal=password=12345678 --namespace=eks-wordpress-si3mshady || true && echo 'pass' && \\
            
            kubectl apply -f ./mysql_deployment*dev.yml --namespace=eks-wordpress-si3mshady || true && echo 'pass'  && \\    
              

            kubectl apply -f ./wordpress_deployment*dev.yml --namespace=eks-wordpress-si3mshady || true && echo 'pass' && \\                        

            namespace=$(kubectl get ns | grep -i si3ms |  awk '{print $1}') || true  && echo 'pass' && \\ 
            loadBalancerDEV=$(kubectl get svc --namespace=$namespace | grep LoadBalancer | awk '{print $4}') || true && echo 'pass' && \\

            sed -i 's/"service.si3mshady.com"/"dev.service.si3mshady.com"/g' CNAME.json || true && echo 'pass'  && \\
            sed -i 's/"\$loadBalancerURL"/"\$loadBalancerDEV"/g' CNAME.json  || true && echo 'pass'  && \\

            aws route53 change-resource-record-sets \\
            --hosted-zone-id Z099267523KVY5EITOQ5W \\
            --change-batch file://CNAME.json                           
                      
        ''')

        
    }

    
}


