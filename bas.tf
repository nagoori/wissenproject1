# create bastion server
# add ami liunx
# selete instance type
#selete the public subnet id
#add  the bastion sg id
#launch the key pair(ssh-keygen local)
# copy the key pair into pem file
#tag the name




resource "aws_instance" "bastion" {
  ami             = "ami-0f511ead81ccde020"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.pubsubnet-1.id
  security_groups = ["${aws_security_group.bastion-security-roup.id}"]
  key_name        = "${aws_key_pair.petclinic.key_name}"
  tags = {
    Name = "bastion"
  }
}





resource "aws_key_pair" "petclinic" {
  key_name   = "petclinic-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC9L1WIaRaT7lFQYT6cD9/+I76IkH/c5GnyxTfV0VWTShoBEPIkwd19Gnvg3rqJ3oNz3R/O8ZtZ2QwwWbf9JAASd7JTqmUCRHkOrDzu5UXmvIKHNWCZ/89IPFPZ91YoXdPEPA+sk7LZwyENPybOc2GjKZ7aPrvp/ZO7w/QcT/yLi5ox1SG/9yvMmhWgCEU+uaekMsrLVTSGmwGNhYmQ2zoNHniThtPcd+wCrl0GdfuwTxZ1txozCQCRDQ0vHMIu0FlTfBbadIaUseOd4sFZj1DCzK6chEU8rsOQpgNp2yzPS1FHCA5iLWeD25shZIsJ7q9ESv5nolgeZMPPoC6Pewd0+iI4787Xg2AOOBLhfusnMWPQ5J3PoOob/AZsAAc26wgf5xXbmcSptYdGB87MJSIxX6cGEgUPAbbBuum5wB/p7x27rDhYmHTz91GVVw+1HgvLMYI/9I1xERpG9npUxT2shRcZv03Qi7Ek1e804euvLWgJ3aN7pKil8mDVDf2muj8= reddy@LAPTOP-DNQJUQ31"
}