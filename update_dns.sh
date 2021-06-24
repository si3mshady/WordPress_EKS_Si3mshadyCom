namespace=$(kubectl get ns | grep -i si3ms |  awk '{print $1}')
loadBalancerURL=$(kubectl get svc --namespace=$namespace | grep LoadBalancer | awk '{print $4}')

sed -i 's/"a.example.com"/service.si3mshady.com/g' CNAME.json
sed -i 's/4.4.4.4/$loadBalancerURL/g' CNAME.json  

aws route53 change-resource-record-sets \
--hosted-zone-id Z099267523KVY5EITOQ5W --change-batch file://CNAME.json
