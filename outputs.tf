output "ssh_to_server" {
  value = "ssh ${local.user}@${aws_instance.instance.public_ip}"
}

output "vpn_usage" {
  value = "sudo openvpn --config ~/${var.openvpn_client_name}.ovpn"
}

output "proxy_usage" {
  value = <<-EOT
    %{for v in ["", "s"]}
      export http${v}_proxy=http://${var.squid_user}:${var.squid_password}@${aws_instance.instance.public_ip}:${var.squid_port}
    %{endfor}
  EOT
}

output "closing_message" {
  value = "Your <OpenVPN over Shadowsocks> and <HTTP Proxy> are ready!"
}
