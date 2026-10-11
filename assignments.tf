
resource "okta_app_group_assignments" "scim_test" {
  app_id = okta_app_saml.scim_test.id
  group {
    id       = okta_group.main_group.id
    priority = 0
    profile = jsonencode({
      costCenter        = null
      department        = null
      division          = null
      entitlements      = null
      locale            = null
      organization      = null
      preferredLanguage = null
      roles             = null
      timezone          = null
      userType          = null
    })

  }

  lifecycle {
    prevent_destroy = true
  }
}

## test ci/cd