.PHONY: check ssh

check:
	pre-commit run -a

ssh:
	ssh ubuntu@$$(echo "aws_instance.instance.public_ip" | terraform console)
