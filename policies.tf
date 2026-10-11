resource "okta_app_signon_policy" "webapp01" {
  name        = "webapp01 sign-in"
  description = "Expenses sign-in: MegasXLR members with two factors. Everyone else is denied."
  catch_all   = false
}

resource "okta_app_signon_policy_rule" "webapp01_members" {
  policy_id = okta_app_signon_policy.webapp01.id
  name      = "MegasXLR members, 2FA"
  priority  = 1

  access          = "ALLOW"
  groups_included = [okta_group.main_group.id]

  factor_mode                 = "2FA"
  re_authentication_frequency = "PT12H"
}