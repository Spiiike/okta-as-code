resource "okta_app_signon_policy" "app_2fa" {
  name        = "app_2fa"
  description = "Application based 2FA policy. Shared by every app gated on MegasXLR."
  catch_all   = false
}

moved {
  from = okta_app_signon_policy.webapp01
  to   = okta_app_signon_policy.app_2fa
}

moved {
  from = okta_app_signon_policy_rule.webapp01
  to   = okta_app_signon_policy_rule.app_2fa
}

resource "okta_app_signon_policy_rule" "webapp01_deny_nonmembers" {
  policy_id       = okta_app_signon_policy.app_2fa.id
  name            = "Deny non-members"
  priority        = 1
  access          = "DENY"
  groups_excluded = [okta_group.main_group.id]
}

resource "okta_app_signon_policy_rule" "webapp01_mfa_exempt" {
  policy_id                   = okta_app_signon_policy.app_2fa.id
  name                        = "MFA-exempt members, 1FA"
  priority                    = 2
  access                      = "ALLOW"
  groups_included             = [okta_group.mfa_exempt.id]
  factor_mode                 = "1FA"
  re_authentication_frequency = "PT12H"

  depends_on = [okta_app_signon_policy_rule.webapp01_deny_nonmembers]
}

resource "okta_app_signon_policy_rule" "app_2fa" {
  policy_id                   = okta_app_signon_policy.app_2fa.id
  name                        = "MegasXLR members, 2FA"
  priority                    = 3
  access                      = "ALLOW"
  groups_included             = [okta_group.main_group.id]
  factor_mode                 = "2FA"
  re_authentication_frequency = "PT12H"

  depends_on = [okta_app_signon_policy_rule.webapp01_mfa_exempt]
}