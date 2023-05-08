resource "aws_instance" "instances" {
  for_each = { for idx, instance in local.config.instances : idx => instance }

  ami           = each.value.ami
  instance_type = try(each.value.instance_type, "t2.micro")
  subnet_id     = try(each.value.subnet_id, null)
  key_name      = try(each.value.key_name, null)
  associate_public_ip_address = try(each.value.public_ip, false)
  iam_instance_profile = try(each.value.instance_profile, null)
  tags = {
    Name = each.value.name
  }

  root_block_device {
    volume_size = try(each.value.volume_size, 20)
    volume_type = try(each.value.volume_type, "gp3")

    tags = {
      Name = each.value.name
    }
  }
}
