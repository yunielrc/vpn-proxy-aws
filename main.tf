locals {
  id          = "vpn-proxy-aws"
  user        = "ubuntu"
  cidr_blocks = ["0.0.0.0/0"]
  sufix       = formatdate("YYYYMMDDhhmmss", timestamp())
  p_data      = "./provision/data"
  p_scripts   = "./provision/scripts"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${local.id}-key-pair-${local.sufix}"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "security_group" {
  name = "${local.id}-security-group-${local.sufix}"

  ingress {
    description = "open vpn"
    from_port   = var.openvpn_port
    to_port     = var.openvpn_port
    protocol    = "udp"
    cidr_blocks = local.cidr_blocks
  }

  ingress {
    description = "http proxy"
    from_port   = var.squid_port
    to_port     = var.squid_port
    protocol    = "tcp"
    cidr_blocks = local.cidr_blocks
  }

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = local.cidr_blocks
  }

  egress {
    description = "outgoing"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.cidr_blocks
  }
}

resource "aws_instance" "instance" {
  ami                    = var.amis[var.region] # us-east-2 ubuntu 20.04 x64
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_group.id]
  key_name               = aws_key_pair.key_pair.id

  connection {
    type  = "ssh"
    host  = self.public_dns
    user  = local.user
    agent = true
  }

  # UPLOAD DATA
  provisioner "file" {
    source      = local.p_data
    destination = "/home/${local.user}"
  }

  # PROVISION

  # setup docker
  provisioner "remote-exec" {
    inline = ["wget -qO - https://git.io/JJaKZ?=docker-ubuntu | bash"]
  }

  # upload scripts
  provisioner "file" {
    source      = local.p_scripts
    destination = "/tmp/scripts"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts/setup-openvpn /tmp/scripts/setup-squid",
      <<-EOT
        PUBLIC_IP=${self.public_ip} \
        OPENVPN_PORT=${var.openvpn_port} \
        OPENVPN_CLIENT_NAME=${var.openvpn_client_name} \
        /tmp/scripts/setup-openvpn
      EOT
      ,
      <<-EOT
        SQUID_PORT=${var.squid_port} \
        SQUID_USER=${var.squid_user} \
        SQUID_PASSWORD=${var.squid_password} \
        /tmp/scripts/setup-squid
      EOT
    ]
  }

  provisioner "local-exec" {
    command = <<-EOT
      ssh-keyscan -T 120 ${self.public_ip} >> ~/.ssh/known_hosts
      scp ${local.user}@${self.public_ip}:~/${var.openvpn_client_name}.ovpn ~/
    EOT
  }
}
