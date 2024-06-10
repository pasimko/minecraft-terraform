resource "aws_key_pair" "deployer" {
  key_name   = "minecraft_key"
  public_key = file("${path.module}/ssh_keys/minecraft_key.pub")
}
