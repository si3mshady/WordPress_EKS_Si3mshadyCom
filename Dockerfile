FROM jenkins/jenkins 

USER root
RUN apt-get update -y
RUN apt-get install -y python3-pip



#use the following syntax to pass secret env variable to Docker at run time
#required for EKS to access ENV vars and is the most secure way to pass ENV 

# sudo docker run -d  -e AWS_ACCESS_KEY_ID=888 \
# -e AWS_SECRET_ACCESS_KEY=888 \
# -e AWS_DEFAULT_REGION=us-east-1 \
#  -v ${PWD}/jenkins_home:/var/jenkins_home -d  -p 8080:8080 si3mshady/jenkins-iam-root


#without the following command transitioned to IMDSv2
#Jenkins is unable to fetch IAM credentials from IAM via the Metadata service - just times out
# instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)
# aws ec2 modify-instance-metadata-options \
#     --instance-id i-1234567898abcdef0 \
#     --http-put-response-hop-limit 2 \
#     --http-endpoint enabled


