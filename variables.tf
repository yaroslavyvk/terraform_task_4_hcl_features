variable "prefix" {
  default     = "tfvmex"
  description = "Prefix for azure resources"
}

variable "vm_number" {
  type        = number
  description = "Number of virtual machine to create"
  default     = 3
}

variable "security_rules" {
  type = list(object({
    name                   = string
    priority               = number
    destination_port_range = string
  }))
  default = [
    {
      name                   = "allow-ssh"
      priority               = 100
      destination_port_range = "22"
    },
    {
      name                   = "allow-http"
      priority               = 200
      destination_port_range = "80"
    }
  ]
}

variable "admin_username" {
  type    = string
  default = "testadmin"
}

variable "admin_password" { # I have set an environment variable before running Terraform commands export TF_VAR_admin_password=""
  type      = string
  sensitive = true
}
