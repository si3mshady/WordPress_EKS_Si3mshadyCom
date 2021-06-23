FROM jenkins/jenkins 

USER root
RUN apt-get update -y
RUN apt-get install -y python3-pip

