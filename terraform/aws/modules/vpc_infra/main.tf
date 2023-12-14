
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

# -- SUBNET --

resource "aws_subnet" "subnet_az1_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone       = "${var.availability_zone}a"   

  tags = {
    Name = "subnet-az1-public"
  }
}

resource "aws_subnet" "subnet_az1_private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone       = "${var.availability_zone}a"

  tags = {
    Name = "subnet-az1-private"
  }
}

resource "aws_subnet" "subnet_az2_public" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone       = "${var.availability_zone}b"

  tags = {
    Name = "subnet-az2-public"
  }
}

resource "aws_subnet" "subnet_az2_private" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone       = "${var.availability_zone}b"  

  tags = {
    Name = "subnet-az2-private"
  }
}

# -- INTERNET / NAT --
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "internet-gw"
  }
}

resource "aws_eip" "my_eip" {}

resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.subnet_az1_public.id

  tags = {
    Name = "nat-gw"
  }
}

# -- ROUTE TABLE --

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public-route-table"
  }
}

# -- ROUTE PRIVATE --

resource "aws_route" "private_route_to_nat_gateway" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id          = aws_nat_gateway.gw.id
}

resource "aws_route_table_association" "subnet_az1_private_association" {
  subnet_id      = aws_subnet.subnet_az1_private.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "subnet_az2_private_association" {
  subnet_id      = aws_subnet.subnet_az2_private.id
  route_table_id = aws_route_table.private_route_table.id
}

# -- ROUTE PUBLIC -- 

resource "aws_route" "route_to_internet_gateway" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "subnet_az1_public_association" {
  subnet_id      = aws_subnet.subnet_az1_public.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "subnet_az2_public_association" {
  subnet_id      = aws_subnet.subnet_az2_public.id
  route_table_id = aws_route_table.public_route_table.id
}

