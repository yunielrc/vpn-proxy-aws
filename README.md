# vpn-proxy-aws

## Overview

Setup ec2 instance with openvpn &amp; squid http proxy

## Usage

```sh
terraform init
terraform apply
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.10 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.10 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amis | n/a | `map(string)` | <pre>{<br>  "us-east-2": "ami-01237fce26136c8cc"<br>}</pre> | no |
| instance\_type | n/a | `string` | `"t2.micro"` | no |
| name | n/a | `string` | `"vpn-proxy"` | no |
| openvpn\_client\_name | n/a | `string` | `"client-profile"` | no |
| profile | n/a | `string` | `"default"` | no |
| region | n/a | `string` | `"us-east-2"` | no |
| squid\_password | n/a | `string` | n/a | yes |
| squid\_port | n/a | `number` | `3128` | no |
| squid\_user | n/a | `string` | n/a | yes |
| ss\_client\_port | n/a | `number` | `1080` | no |
| ss\_password | n/a | `string` | n/a | yes |
| ss\_port | n/a | `number` | `443` | no |

## Outputs

| Name | Description |
|------|-------------|
| closing\_message | n/a |
| proxy\_usage | n/a |
| ssh\_to\_server | n/a |
| vpn\_usage | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Development

### Prerequisites

- [terraform](https://learn.hashicorp.com/terraform/getting-started/install#installing-terraform)
- [terraform-docs](https://github.com/segmentio/terraform-docs)
- [pre-commit](https://pre-commit.com/#install)

### Configurations

- Configure pre-commit hooks

```sh
pre-commit install
```

## Authors

This project is authored by below people

- yunielrc

> This project was generated by [generator-tf-module](https://github.com/sudokar/generator-tf-module)
