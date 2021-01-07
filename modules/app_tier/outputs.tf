# This is where you can define values to be accessed elsewhere
output app_public_ip {
    description = "public ip of app ec2 instance"
    value = aws_instance.app_instance.public_ip
}