import subprocess


def deploy():
    try:
        result = subprocess.Popen("eksctl create cluster -f  base-wordpress-cluster.yml", \
             stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass
    try:
        result = subprocess.Popen("kubectl create namespace eks-wordpress-si3mshady" , \
             stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass
    try:
        result = subprocess.Popen("kubectl apply -f ./wp_storage_class.yml \
            --namespace=eks-wordpress-si3mshady", stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass
    try:
        result = subprocess.Popen("kubectl patch storageclass gp2 -p \
            '{\"metadata\": {\"annotations\":{\"storageclass.kubernetes.io/is-default-class\":\"true\"}}}' \
            --namespace=eks-wordpress-si3mshady", stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass
    try:
        result = subprocess.Popen("kubectl apply -f ./persistent_volume_claim.yml \
            --namespace=eks-wordpress-si3mshady", stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass
    try:
        result = subprocess.Popen("kubectl create secret generic mysql-pass \
                --from-literal=password=12345678 \
                --namespace=eks-wordpress-si3mshady", stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass
    try:
        result = subprocess.Popen("kubectl apply -f ./mysql_deployment.yml \
            --namespace=eks-wordpress-si3mshady", stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass

    try:
        result = subprocess.Popen("kubectl apply -f ./wordpress_deployment.yml \
            --namespace=eks-wordpress-si3mshady ", stdout=subprocess.PIPE, shell=True)
        (out, err) = result.communicate()
    except Exception:
        pass

if __name__ == "__main__":
    deploy()
   
   