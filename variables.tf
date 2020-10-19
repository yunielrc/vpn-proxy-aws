variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "amis" {
  type = map(string)
  default = {
    us-east-2 = "ami-01237fce26136c8cc"
  }
}

# SQUID

variable "squid_port" {
  default = 3128
}

variable "squid_user" {
  type = string
}

variable "squid_password" {
  type = string
}

# OPENVPN

variable "openvpn_port" {
  default = 1194
}

variable "openvpn_client_name" {
  default = "vpn-profile"
}
