resource "aws_vpc" "terraform-vpc" {
  cidr_block           = var.vpc-cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "Terraform VPC"
  }
}

#create Internet Gateway and attach to Public Subnet
#Terraform Aws InternetGateway
resource "aws_internet_gateway" "internet-gateway" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "Terraform IGW"
  }
}

# Create Public Subnet 1
# terraform aws create subnet
resource "aws_subnet" "pubsubnet-1" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.pubsubnet-1-cidr
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet 1"
  }
}

# Create Public Subnet 2
# terraform aws create subnet
resource "aws_subnet" "pubsubnet-2" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.pubsubnet-2-cidr
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet2"
  }
}
# Create Route Table and Add Public Route
# terraform aws create route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gateway.id
  }

  tags = {
    Name = "Public route Table"
  }
}
# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "pubsubnet-1-route-table-association" {
  subnet_id      = aws_subnet.pubsubnet-1.id
  route_table_id = aws_route_table.public-route-table.id
}
# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "pubsubnet-2-route-table-association" {
  subnet_id      = aws_subnet.pubsubnet-2.id
  route_table_id = aws_route_table.public-route-table.id
}

# Create Private Subnet 1
# terraform aws create subnet
resource "aws_subnet" "private-subnet-1" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.private-subnet-1-cidr
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 1"
  }
}
# Create Private Subnet 2
# terraform aws create subnet
resource "aws_subnet" "private-subnet-2" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.private-subnet-2-cidr
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 2"
  }
}
# Create Private Subnet 3
# terraform aws create subnet
resource "aws_subnet" "private-subnet-3" {
  vpc_id                  = aws_vpc.terraform-vpc.id
  cidr_block              = var.private-subnet-3-cidr
  availability_zone       = "ap-southeast-1c"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet 3 - DB"
  }
}
# Create Private Subnet 4
# terraform aws create subnet
# resource "aws_subnet" "private-subnet-4" {
#   vpc_id                  = aws_vpc.terraform-vpc.id
#   cidr_block              = var.private-subnet-4-cidr
#   availability_zone       = "ap-southeast-1d"
#   map_public_ip_on_launch = false

#   tags = {
#     Name = "Private Subnet 4 - DB"
#   }
# }
#create nat gate way
#create elp ip allocation nat gate  way

resource "aws_eip" "hip" {
  vpc = true
}
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.hip.id
  subnet_id     = aws_subnet.pubsubnet-2.id

  tags = {
    Name = "NGW"
  }
}

resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.terraform-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "private route Table"
  }
}
# Associate Public Subnet 1 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-1-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-route-table.id
}
# Associate Public Subnet 2 to "Public Route Table"
# terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-2-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-3-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-route-table.id
}
resource "aws_route_table_association" "private-subnet-4-route-table-association" {
  subnet_id      = aws_subnet.private-subnet-4.id
  route_table_id = aws_route_table.private-route-table.id
}  