terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.13.0"
    }
  }
}

resource "docker_image" "jenkins_image" {
  name = "jenkins/jenkins:latest"
}

resource "docker_container" "jenkins" {
  name  = "jenkins"
  image = docker_image.jenkins_image.latest
  volumes {
    container_path = "/var/jenkins_home"
    host_path = "/home/ubuntu/jenkins_home"
  }
 
  ports  {
      internal = 8080
      external = 8080
  }
  
}

resource "null_resource" "mkdir" {
  provisioner "local-exec" {
    command = "mkdir /home/ubuntu/jenkins_home || true && sudo chown -R 1000:1000 /home/ubuntu/jenkins_home"      
   
  }
}