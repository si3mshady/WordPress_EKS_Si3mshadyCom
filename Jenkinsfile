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
            
            instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)

            aws ec2 modify-instance-metadata-options \
            --instance-id $instance_id \
            --http-put-response-hop-limit 2 \
            --http-endpoint enabled \
            --region us-east-1 

            python3 ./deployment_handler.py && namespace=$(kubectl get ns | grep -i si3ms |  awk '{print $1}') && \
            
            loadBalancerURL=$(kubectl get svc --namespace=$namespace | grep LoadBalancer | awk '{print $4}') && \

            sed -i 's/"a.example.com"/"service.si3mshady.com"/g' CNAME.json || true && echo 'pass'  && \
            sed -i 's/"8.8.8.8"/"$loadBalancerURL"/g' CNAME.json  || true && echo 'pass'  && \

            aws route53 change-resource-record-sets \
            --hosted-zone-id Z099267523KVY5EITOQ5W \
            --change-batch file://CNAME.json        
        ''')

         
    
        
    }

    
}


