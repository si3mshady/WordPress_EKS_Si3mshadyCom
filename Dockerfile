FROM jenkins/jenkins 

USER root
RUN apt-get update -y
RUN apt-get install -y python3-pip



#use the following syntax to pass secret env variable to Docker at run time
#required for EKS to access ENV vars and is the most secure way to pass ENV 

sudo docker run -d  -e AWS_ACCESS_KEY_ID=AKIAZ2BODUTWVZB46SG2,AWS_SECRET_ACCESS_KEY=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 \
 -v ${PWD}/jenkins_home:/var/jenkins_home -d  -p 8080:8080 si3mshady/jenkins-iam-root