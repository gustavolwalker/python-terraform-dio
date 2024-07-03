terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 4.16"
        }
    }
    required_version = ">= 1.2.0"
}

provider "aws" {
    region = "us-east-1"
    #profile = "gustavo" #if you using profile umcomment this and adjust 
}

#NETWORKING
resource "aws_default_vpc" "default_vpc" {}

resource "aws_default_subnet" "us_east_1a" {
    availability_zone = "us-east-1a"
}

resource "aws_default_subnet" "us_east_1b" {
    availability_zone = "us-east-1b"
}

#SECURITY GROUP - RULES INBOUND OUTBOUND
resource "aws_security_group" "sg" {
    name="sg"
    vpc_id=aws_default_vpc.default_vpc.id

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port=22
        to_port=22
        protocol="tcp"
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port=80
        to_port=80
        protocol="tcp"
    }

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port=5432
        to_port=5432
        protocol="tcp"
    }

    egress {
        cidr_blocks = ["0.0.0.0/0"]
        from_port=0
        to_port=0
        protocol=-1
    }  
}

#DATABASE
resource "aws_db_subnet_group" "dsg_postgres" {
    name="dsg_postgres"
    subnet_ids = [aws_default_subnet.us_east_1a.id, aws_default_subnet.us_east_1b.id] 
}

resource "aws_db_instance" "postgres" {
    allocated_storage = 10
    db_name = "postgres"
    engine = "postgres"
    engine_version = "16.3"
    instance_class = "db.t3.micro"
    username = "postgres"
    password = "postgres"
    skip_final_snapshot = true  
    db_subnet_group_name = aws_db_subnet_group.dsg_postgres.name
    vpc_security_group_ids = [aws_security_group.sg.id]
}

#INSTANCE EC2
resource "aws_key_pair" "wargate" {
    key_name = "wargate_key"
    public_key="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/KkmlpHOAB46y7WESyYQgtdaGxIA0mtR/zyfi562pR gustavo@wargate"
}

resource "aws_instance" "app_server" {
    ami = "ami-04b70fa74e45c3917"
    instance_type = "t2.micro"
    key_name = aws_key_pair.wargate.key_name
    associate_public_ip_address = true
    subnet_id = aws_default_subnet.us_east_1a.id
    vpc_security_group_ids = [aws_security_group.sg.id]

  
}