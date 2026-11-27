locals {
  name = "${var.project_name}-${var.environment}"
}

# VPC : réseau privé isolé
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = { Name = "${local.name}-vpc" }
}

# Internet Gateway : porte du VPC vers Internet
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = { Name = "${local.name}-igw" }
}

# Sous-réseaux publics (ALB, NAT)
resource "aws_subnet" "public" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = { Name = "${local.name}-public-${count.index + 1}", Tier = "public" }
}

# Sous-réseaux privés applicatifs
resource "aws_subnet" "private_app" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_app_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = { Name = "${local.name}-app-${count.index + 1}", Tier = "app" }
}

# Sous-réseaux privés de la base de données
resource "aws_subnet" "private_db" {
  count             = length(var.azs)
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_db_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = { Name = "${local.name}-db-${count.index + 1}", Tier = "db" }
}

# Routage public : tout le trafic Internet passe par l'IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = { Name = "${local.name}-public-rt" }
}

resource "aws_route_table_association" "public" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# NAT Gateway unique (coût maîtrisé) : sortie Internet des instances privées
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = { Name = "${local.name}-nat-eip" }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = { Name = "${local.name}-nat" }

  depends_on = [aws_internet_gateway.this]
}

# Routage des sous-réseaux applicatifs : sortie via le NAT
resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this.id
  }

  tags = { Name = "${local.name}-app-rt" }
}

resource "aws_route_table_association" "private_app" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app.id
}

# Routage des sous-réseaux de base de données : aucune route vers Internet
resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.this.id

  tags = { Name = "${local.name}-db-rt" }
}

resource "aws_route_table_association" "private_db" {
  count          = length(var.azs)
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private_db.id
}
