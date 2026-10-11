resource "okta_app_signon_policy" "webapp01" {
  name        = "webapp01 sign-in"
  description = "Expenses sign-in: MegasXLR members with two factors. Everyone else is denied."
  catch_all   = false
}

resource "okta_app_signon_policy_rule" "webapp01_members" {
  policy_id = okta_app_signon_policy.webapp01.id
  name      = "MegasXLR members, 2FA"
  priority  = 3   # was 1

  access          = "ALLOW"
  groups_included = [okta_group.main_group.id]

  factor_mode                 = "2FA"
  re_authentication_frequency = "PT12H"

  depends_on = [okta_app_signon_policy_rule.webapp01_mfa_exempt]
}

resource "okta_app_signon_policy_rule" "webapp01_deny_nonmembers" {
  policy_id       = okta_app_signon_policy.webapp01.id
  name            = "Deny non-members"
  priority        = 1
  access          = "DENY"
  groups_excluded = [okta_group.main_group.id]
}

resource "okta_app_signon_policy_rule" "webapp01_mfa_exempt" {
  policy_id                   = okta_app_signon_policy.webapp01.id
  name                        = "MFA-exempt members, 1FA"
  priority                    = 2
  access                      = "ALLOW"
  groups_included             = [okta_group.mfa_exempt.id]
  factor_mode                 = "1FA"
  re_authentication_frequency = "PT12H"

  depends_on = [okta_app_signon_policy_rule.webapp01_deny_nonmembers]
}