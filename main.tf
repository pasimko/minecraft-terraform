terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region = var.aws_region
}

resource "aws_key_pair" "minecraft_key_pair" {
    key_name   = "minecraft-key-pair"
    public_key = file(var.public_key_path)
}

resource "aws_instance" "minecraft_server" {
    ami           = "ami-02e8e2a390064c712"
    instance_type = "t2.small"
    key_name      = aws_key_pair.minecraft_key_pair.key_name

    tags = {
        Name = "MinecraftServerInstance"
    }

    security_groups = [aws_security_group.minecraft_sg.name]

    provisioner "file" {
        source      = "minecraft-server.service"
        destination = "/tmp/minecraft-server.service"
        connection {
            type        = "ssh"
            user        = "ec2-user"
            private_key = file(var.private_key)
            host        = self.public_ip
        }
    }

    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo amazon-linux-extras install docker -y",
            "sudo service docker start",
            "sudo usermod -a -G docker ec2-user",
            "sudo docker pull itzg/minecraft-server",
            "sudo docker run -d -p 25565:25565 --name minecraft -e EULA=TRUE itzg/minecraft-server"
        ]
        connection {
            type        = "ssh"
            user        = "ec2-user"
            private_key = file(var.private_key)
            host        = self.public_ip
        }
    }
}
