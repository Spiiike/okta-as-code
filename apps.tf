resource "okta_app_oauth" "webapp01" {
  accessibility_self_service = false
  app_settings_json = jsonencode({
    app                = {}
    manualProvisioning = false
  })
  authentication_policy                = okta_app_signon_policy.webapp01.id
  auto_key_rotation                    = true
  auto_submit_toolbar                  = false
  client_id                            = "0oa17safg6d3Iix1o698"
  consent_method                       = "REQUIRED"
  frontchannel_logout_session_required = false
  grant_types                          = ["authorization_code", "refresh_token"]
  hide_ios                             = true
  hide_web                             = true
  implicit_assignment                  = true
  issuer_mode                          = "DYNAMIC"
  label                                = "webapp01"
  login_mode                           = "DISABLED"
  login_scopes                         = []
  omit_secret                          = true
  participate_slo                      = false
  pkce_required                        = false
  post_logout_redirect_uris            = ["https://wetcliff-a5bcemhpa3c2dmgn.eastus2-01.azurewebsites.net/labs/identity/expenses"]
  redirect_uris                        = ["https://wetcliff-a5bcemhpa3c2dmgn.eastus2-01.azurewebsites.net/labs/identity/expenses/auth/callback"]
  refresh_token_rotation               = "STATIC"
  response_types                       = ["code"]
  status                               = "ACTIVE"
  token_endpoint_auth_method           = "client_secret_basic"
  type                                 = "web"
  user_name_template                   = "$${source.login}"
  user_name_template_type              = "BUILT_IN"
  wildcard_redirect                    = "DISABLED"
}

resource "okta_app_saml" "scim_test" {
  authentication_policy       = "rst14lmibu1lAIBTC698"
  honor_force_authn           = false
  implicit_assignment         = false
  label                       = "SCIM 2.0 Test App (OAuth Bearer Token)"
  preconfigured_app           = "scim2testapp"
  response_signed             = false
  saml_signed_request_enabled = false
  status                      = "ACTIVE"
  user_name_template          = "$${source.login}"
  user_name_template_type     = "BUILT_IN"
}
check "scim_deprovisioning_enabled" {
  assert {
    condition     = contains(okta_app_saml.scim_test.features, "PUSH_USER_DEACTIVATION")
    error_message = "SCIM app no longer deactivates users downstream. Leavers would keep access in webapp01. Check the app's Provisioning tab."
  }
}