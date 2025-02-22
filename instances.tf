
data "aws_ami" "node_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = [var.ami_name]
  }
  owners = [var.ami_owner]
}

resource "aws_instance" "node_group_1" {
  count                       = var.instance_count_a
  ami                         = data.aws_ami.node_ami.image_id
  instance_type               = var.instance_type_a
  key_name                    = aws_key_pair.ssh.id
  user_data                   = local.instance_user_data
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = var.node_group_1_subnet_id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  ebs_optimized               = true
  root_block_device {
    volume_type = var.node_volume_type
    volume_size = var.node_volume_size
  }
  tags = merge(module.label.tags,
    {
      "Name" = "${module.label.id}-rancher-master-1.${count.index}"
  })
  provisioner "remote-exec" {
    connection {
      host        = self.public_ip
      user        = local.ssh_user
      private_key = tls_private_key.ssh.private_key_pem
    }
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'"
    ]
  }
}

resource "aws_instance" "node_group_2" {
  count                       = var.instance_count_b
  ami                         = data.aws_ami.node_ami.image_id
  instance_type               = var.instance_type_b
  key_name                    = aws_key_pair.ssh.id
  user_data                   = local.instance_user_data
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = var.node_group_2_subnet_id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  ebs_optimized               = true
  root_block_device {
    volume_type = var.node_volume_type
    volume_size = var.node_volume_size
  }
  tags = merge(module.label.tags,
    {
      "Name" = "${module.label.id}-rancher-master-2.${count.index}"
  })
  provisioner "remote-exec" {
    connection {
      host        = self.public_ip
      user        = local.ssh_user
      private_key = tls_private_key.ssh.private_key_pem
    }
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'"
    ]
  }
}

resource "aws_instance" "node_group_3" {
  count                       = var.instance_count_a
  ami                         = data.aws_ami.node_ami.image_id
  instance_type               = var.instance_type_a
  key_name                    = aws_key_pair.ssh.id
  user_data                   = local.instance_user_data
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = var.node_group_3_subnet_id
  associate_public_ip_address = true #tfsec:ignore:AWS012
  ebs_optimized               = true
  root_block_device {
    volume_type = var.node_volume_type
    volume_size = var.node_volume_size
  }
  tags = merge(module.label.tags,
    {
      "Name" = "${module.label.id}-rancher-master-3.${count.index}"
  })
  provisioner "remote-exec" {
    connection {
      host        = self.public_ip
      user        = local.ssh_user
      private_key = tls_private_key.ssh.private_key_pem
    }
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'"
    ]
  }
}

resource "aws_instance" "node_group_4" {
  count                       = var.instance_count_b
  ami                         = data.aws_ami.node_ami.image_id
  instance_type               = var.instance_type_b
  key_name                    = aws_key_pair.ssh.id
  user_data                   = local.instance_user_data
  vpc_security_group_ids      = [aws_security_group.nodes.id]
  subnet_id                   = var.node_group_4_subnet_id
  associate_public_ip_address = true
  ebs_optimized               = true
  root_block_device {
    volume_type = var.node_volume_type
    volume_size = var.node_volume_size
  }
  tags = merge(module.label.tags,
    {
      "Name" = "${module.label.id}-rancher-master-4.${count.index}"
  })
  provisioner "remote-exec" {
    connection {
      host        = self.public_ip
      user        = local.ssh_user
      private_key = tls_private_key.ssh.private_key_pem
    }
    inline = [
      "echo 'Waiting for cloud-init to complete...'",
      "cloud-init status --wait > /dev/null",
      "echo 'Completed cloud-init!'"
    ]
  }
}
