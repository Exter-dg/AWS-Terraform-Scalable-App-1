output "alb_domain" {
    description = "URL for ALB"
    value       = aws_lb.myAlb.dns_name
}