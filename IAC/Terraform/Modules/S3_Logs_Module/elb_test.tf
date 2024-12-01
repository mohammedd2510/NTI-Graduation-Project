# resource "aws_lb" "alb_prod" {
#   name                       = "alb-prod"
#   internal                   = false
#   load_balancer_type         = "application"
#   security_groups            = [var.Security_group_id]
#   subnets                    = [var.Public_Subnet1_id, var.Public_Subnet2_id]


#   access_logs {
#     enabled  = true
#     bucket  = "logs-prod-2510"
#   }

#   tags = {
#     Environment = "prod"
#   }
#   depends_on = [ aws_s3_bucket.logs_prod ]
# }
