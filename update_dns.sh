namespace=$(kubectl get ns | grep -i si3ms |  awk '{print $1}')
loadBalancerURL=$(kubectl get svc --namespace=$namespace | grep LoadBalancer | awk '{print $4}')

aws route53 change-resource-record-sets CREATE
aws route53 change-resource-record-sets