
# Generate key
resource "tls_private_key" "default" {
  algorithm = "RSA"
}


# Add key to AWS
resource "aws_key_pair" "generated" {
  depends_on = [tls_private_key.default]
  key_name   = var.name
  public_key = tls_private_key.default.public_key_openssh
  tags       = var.tags
}


# Store in secret manager
resource "aws_secretsmanager_secret" "pem" {
  name        = "${var.name}-${random_string.name.result}"
  description = "Keypair (${var.name}) - private key"
  tags        = var.tags
}
resource "aws_secretsmanager_secret_version" "pem" {
  secret_id     = aws_secretsmanager_secret.pem.id
  secret_string = tls_private_key.default.private_key_pem
}

# Random characters added to secret name, making it unique and allowing plan -destory and recreate, since secrets are not deleted right away
resource "random_string" "name" {
  length  = 4
  special = false
}
