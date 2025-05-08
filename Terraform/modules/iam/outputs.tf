# References: https://spacelift.io/blog/terraform-output
# Output variables

# ===================================== Using for IAM user ======================================
## For access keys
output "iam_access_key_id" {
  description = "The access key ID from iam_user module"
  value       = module.iam_user.iam_access_key_id
}

output "keybase_secret_key_decrypt_command" {
  description = "Decrypt access secret key command"
  value       = module.iam_user.keybase_secret_key_decrypt_command
}

## For credentials
output "iam_user_name" {
  description = "The user's name"
  value       = module.iam_user.iam_user_name
}

output "keybase_password_decrypt_command" {
  description = "Decrypt access secret key command"
  value       = module.iam_user.keybase_password_decrypt_command
}

output "iam_user_arn" {
  description = "The unique ID assigned by AWS"
  value       = module.iam_user.iam_user_arn
}

## PGP key
output "pgp_key" {
  description = "PGP key used to encrypt sensitive data for this user (if empty - secrets are not encrypted)"
  value       = module.iam_user.pgp_key
}

output "iam_user_login_profile_key_fingerprint" {
  description = "The fingerprint of the PGP key used to encrypt the password"
  value       = module.iam_user.iam_user_login_profile_key_fingerprint
}

