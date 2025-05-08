output "name" {
  description = "Name of bucket"
  value       = aws_s3_bucket.state-bucket-manjiro.id
}