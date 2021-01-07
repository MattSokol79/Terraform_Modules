# DB Private IP is required for the DB_HOST Functionality in the App

output db_host_ip {
    description = "ip of the db ec2 instance"
    value = aws_instance.db_instance.private_ip
}