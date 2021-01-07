# Outputs the IP of the Public Instance in the console for ease
output app_public_ip {
    description = "public ip of app ec2 instance"
    value = aws_instance.app_instance.public_ip
}