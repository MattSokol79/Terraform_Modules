# Provides the SG App ID to other modules 
output "app_sg_id" {
    value = aws_security_group.app_sg.id
}

# Provides the SG DB ID to other modules 
output "db_sg_id" {
    value = aws_security_group.db_sg.id
}