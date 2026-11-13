# 1. ดึง Key Pair ที่คุณเพิ่งสร้างในหน้าเว็บ AWS
data "aws_key_pair" "ec2-aws-key" {
  key_name = "ec2-aws-key"
}

# 2. สร้าง VPC ใหม่
resource "aws_vpc" "testvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "TestVPC"
  }
}

# 3. สร้าง Subnet ใหม่
resource "aws_subnet" "private-a-subnet" {
  vpc_id     = aws_vpc.testvpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "PrivateA"
  }
}

# 4. สร้าง Security Group ใหม่
resource "aws_security_group" "private-sg" {
  name        = "PrivateSG"
  description = "Allow SSH"
  vpc_id      = aws_vpc.testvpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 5. สร้าง EC2 และผูกเข้ากับ Key Pair ของคุณ
resource "aws_instance" "web" {
  ami                    = "ami-0d07675d294f17973"
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private-a-subnet.id
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  key_name               = data.aws_key_pair.ec2-aws-key.key_name

  tags = {
    Name = "Nam-Test-WebServer"
  }
}
