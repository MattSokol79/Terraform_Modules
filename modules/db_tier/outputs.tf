output db_host_ip {
    description = "ip of the db ec2 instance"
    value = aws_instance.db_instance.private_ip
}