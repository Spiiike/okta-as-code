resource "okta_group" "main_group" {
  name        = "MegasXLR"
  description = "Testing group with IaC."
}

resource "okta_group" "mfa_exempt" {
  name        = "webapp01 MFA exempt"
  description = "MFA bypass group for webapp01. Membership managed in Terraform. Any other change shows up as drift."
}

resource "okta_group_memberships" "mfa_exempt" {
  group_id        = okta_group.mfa_exempt.id
  users           = []
  track_all_users = true
}