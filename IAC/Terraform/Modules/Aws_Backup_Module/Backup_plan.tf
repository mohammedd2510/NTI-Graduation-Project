# Backup Plan Resource 

resource "aws_backup_plan" "my_back_plan" {
  name = "my-backup-plan"

  rule {
    rule_name         = "my-backup-rule"
    target_vault_name = "Default"
    schedule          = "cron(35 19 * * ? *)"
    completion_window = 120

    lifecycle {
      delete_after = 14
    }
  }
}  