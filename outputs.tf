output "app_public_ip" {
    description = "Outputs the App IP into console once the process has finished"
    value = module.app.app_public_ip
}