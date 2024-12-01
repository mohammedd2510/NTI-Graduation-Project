resource "aws_iam_role" "jenkins_ec2_role" {
  name = "jenkins-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "jenkins_ec2_cloudwatch_logs" {
  role       = aws_iam_role.jenkins_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}
resource "aws_iam_instance_profile" "jenkins_ec2_instance_profile" {
  name = "jenkins-ec2-instance-profile"
  role = aws_iam_role.jenkins_ec2_role.name
}