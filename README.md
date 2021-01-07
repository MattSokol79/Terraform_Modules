# Terraform

Is part of IAC, specifically dealing with orchestration of infrastructure in the cloud.


## AWS Keys
Keep these safe. Do not have them with your code. Set theses in the environment variables or use a vault.

**NOTE**
You don't need to specify the keys when calling the provider IF you have set them as environment variable with the correct naming convention.

## provider

Specify what cloud service to build and orchestrate in

--> read note on setting keys above


## resources

Abstractions of services and components of AWS.

### resource "aws_instance"
Allows us to deploy and aws EC2 instance from specific AMI.

Also allows us to specific diferent paramets such name, subnet, ssk and other.


### resource aws_vpc

this creates vpcs

### resource aws_internet_gateway


## Dynamic Referencing / calling paramters of resources:

We might need to reference ID or other infrastructure values that might not have yet been created.

Terraform allows us to do that dynamically using the resource, it's name and the parameter we want.

Example:
We wanted the id of a vpc that had not been created, we used the vpc resource followed by the name and the parameter VPC_ID.

  #reference vpc_id dynamically by:
  # calling the resource,
  # followed by the name of the resource
  # followed by the parameter you want


## Terraform commands

Terraform:
```bash

$ terraform validate

$ terraform plan

$ terraform apply

```

## Terraform modules
### Using `./modules/app_tier/variables.tf` and `main.tf`
- We can abstract complexity using modules. 
- We have placed all the cde relevant to the app tier in a module caled APP tier. 

- Then we called the module in the 'main' file:

```json
# call the app module
module "app" {
  source = "./modules/app_tier"
}
```
- Then we had to make variables in the `/modules/app_tier/variables.tf` and pass these when calling the app module:

```json
module "app" {
  source = "./modules/app_tier"
  vpc-terraform-name-id = aws_vpc.vpc-terraform-name.id
  eng_class_person = var.eng_class_person
  gw_id = aws_internet_gateway.gw.id
  nodejs_app = var.nodejs_app
  ssh_key = var.ssh_key
}
```

- We also had to adapt the calling of these variables in the `./modules/app_tier/main.tf`

## Using outputs in modules
- When we want to get information from a piece of infrastructure that will be abstracted in the modules. We can use outputs file to get this output. 
- Case in point, we might need to get the SG_app.id so we can allow any instance in this SG to communicate with our DB. 