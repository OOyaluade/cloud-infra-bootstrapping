resource "aws_iam_user" "lb" {
  name = "loadbalancer"
  path = "/system/"


  tags = {
    tag-key = "tag-value"
  }
}

resource "tls_private_key" "pgp" {
    algorithm = "RSA"
    rsa_bits = 4096 
}

resource "aws_iam_access_key" "lb" {
  user    = aws_iam_user.lb.name
}

data "aws_iam_policy_document" "lb_ro" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:Describe*"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "lb_ro" {
  name   = "test"
  user   = aws_iam_user.lb.name
  policy = data.aws_iam_policy_document.lb_ro.json
}

output "secret" {
  value = aws_iam_access_key.lb.encrypted_secret
}

output "access_key_id" {
  value     = aws_iam_access_key.lb.id
  sensitive = true
}

output "secret_access_key" {
  value     = aws_iam_access_key.lb.secret
  sensitive = true
}

resource "local_file" "private_key" {
  content  = <<EOF
Access Key ID: ${aws_iam_access_key.lb.id}
Secret Access Keys: ${aws_iam_access_key.lb.secret}
EOF

  filename = "${path.module}/access_key_details.txt"
  file_permission = "0600"
}
