provider "aws" {
    region = "us-east-1"
}

#creating a vpc

resource "aws_vpc" "vpc-arjun" {
    cidr_block = "20.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    
    tags = {
        Name = "vpc-arjun"

    }
}

# creation of subnet-public and assocaiate vpc

resource "aws_subnet" "subnet-public" {
vpc_id = aws_vpc.vpc-arjun
cidr_block = "20.0.1.0/24"
availability_zone = "us-east-1a"
map_public_ip_on_launch = true

tags = {
  Name = "public"
}
  
}
# creation of subnet-private and assocaiate vpc
resource "aws_subnet" "subnet-private" {
vpc_id = aws_vpc.vpc-arjun.id
cidr_block = "20.0.2.0/24"
availability_zone = "us-east-2a"
map_public_ip_on_launch = true

tags = {
  Name = "public"
}
  
}

#creation of route table
resource "aws_route_table" "public_route_table" {
    vpc_id = aws_vpc.vpc-arjun.id

tags = {
  Name = "public_route_custom"
 }
}

#creaion of internetgateway
resource "aws_internet_gateway" "ig_arjun" {
    vpc_id = aws_vpc.vpc-arjun.id
    tags ={
        Name = "ig_arjun"
    }
  
}

#creating public route
resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_route_table.id
    destination_cidr_block="0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig_arjun.id
}

#route assocaition
resource "aws_route_table_association" "public_route_asscaition" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.subnet-public.id
}
