# Create IAM user "manjiro"
module "iam_user" {
  version = "5.55.0"
  source  = "terraform-aws-modules/iam/aws//modules/iam-user"

  name          = "manjiro"
  force_destroy = true # Allow destroying the user without additional confirmation
  

  create_iam_access_key   = true
  password_reset_required = false
  password_length         = 18

  tags = {
    Name = "Dung"
  }
  # You can add additional configurations for the user here if needed
}

module "iam_group_with_policies" {
  source = "terraform-aws-modules/iam/aws//modules/iam-group-with-policies"

  name = "Admin-manjiro"

  group_users = [
    "manjiro"
  ]

  attach_iam_self_management_policy = true

  custom_group_policy_arns = [
    "arn:aws:iam::aws:policy/AdministratorAccess",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/IAMFullAccess",
    "arn:aws:iam::aws:policy/IAMUserChangePassword",
  ]

}