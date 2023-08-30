module "kms" {
  source = "source  = "app.terraform.io/christophepaget-tfe/vault-ent-starter/aws//modules/kms"

  common_tags               = var.tags
  kms_key_deletion_window   = var.kms_key_deletion_window
  resource_name_prefix      = var.prefix
  user_supplied_kms_key_arn = var.user_supplied_kms_key_arn
}
