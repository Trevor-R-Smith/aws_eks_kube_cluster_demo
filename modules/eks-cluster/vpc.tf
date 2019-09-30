#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table

resource "aws_vpc" "default" {
  cidr_block = var.network_cidr
  tags = merge(local.common_tags, var.default_tags, map(
      "Name", "${var.resource_prefix}-vpc",
      "kubernetes.io/cluster/${local.cluster_name}", "shared",
    ))
}

resource "aws_subnet" "default" {
  count = 3

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = cidrsubnet(var.network_cidr, 8, count.index)
  vpc_id            = aws_vpc.default.id

  tags = merge(local.common_tags, var.default_tags, map(
      "Name", "${var.resource_prefix}-subnet-${count.index + 1}",
      "kubernetes.io/cluster/${local.cluster_name}", "shared",
    ))
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "${var.resource_prefix}-igw"
  }
}

resource "aws_route_table" "default" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = merge(local.common_tags, var.default_tags, map(
    "Name","${var.resource_prefix}-rtb"))

}

resource "aws_route_table_association" "default" {
  count = 2

  subnet_id      = aws_subnet.default.*.id[count.index]
  route_table_id = aws_route_table.default.id
}
