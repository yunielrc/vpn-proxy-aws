variable "region" {
  default = "us-east-2"
}

variable "profile" {
  default = "default"
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

# variable "public_key" {
#   type = string
# }

# variable "aws_access_key" {
#   type = string
# }

# variable "aws_secret_key" {
#   type = string
# }

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

variable "openvpn_protocol" {
  default = "udp"
}

variable "openvpn_client_name" {
  default = "vpn-profile"
}

# SHADOWSOCKS (SS) SERVER

variable "ss_port" {
  default = 443
}

variable "ss_password" {
  type = string
}
