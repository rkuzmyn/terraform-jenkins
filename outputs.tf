
output "jenkins-master_id" {
  value = aws_instance.jenkins-master.id
}

output "jenkins-master_public_ip_address" {
  value = aws_eip.my_static_ip.public_ip
}

output "jenkins_security_group" {
  value = aws_security_group.jenkins.id
}