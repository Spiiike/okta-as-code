# Okta as Code

Terraform-managed configuration for the Okta development tenant supporting the Glasscliff identity lifecycle lab.

This repository manages the Okta control plane behind projects demonstrating joiner, mover, and leaver (JML) operations, OIDC authentication, SCIM provisioning, application assignments, and federation with Microsoft Entra ID and Google Cloud Identity.

## What's Implemented

- **Applications:** OIDC Expenses application and SAML/SCIM provisioning test application.
- **Groups and assignments:** Group-based access, MFA exemption membership, and application assignments.
- **Authentication policies:** Access restrictions, MFA requirements, exemptions, and reauthentication intervals.
- **Resource imports:** Bringing existing Okta resources under Terraform management.
- **Remote state:** Azure Storage backend authenticated through Entra ID.

Terraform manages the Okta configuration, while **IAMDash** handles the application layer, custom SCIM endpoint, reconciliation service, and public-facing lifecycle dashboard.

## Why I Built It

I started this project to address two gaps in my technical experience: **Okta and Terraform**.

I've spent quite a bit of time working with IAM (before even realizing it was an entire field), primarily through Entra ID, Active Directory, and SaaS integrations.

The concepts were familiar, but the platforms and approach weren't. I tried tutorials. They're boring. So I built something I could actually use.

## Change Management

Changes follow a review-first workflow using `terraform fmt`, `validate`, and `plan` before applying. Remote state, resource imports, and `prevent_destroy` provide additional safeguards.

The lab uses real integrations with synthetic identities. It isn't a production deployment, and Terraform doesn't manage every component.

## Live Demonstrations

- [JML Dashboard](https://projects.glasscliff.online/labs/identity/dashboard/)
- [Expenses Application](https://projects.glasscliff.online/labs/identity/expenses)
- [Identity Federation](https://projects.glasscliff.online/labs/identity/federation)
- [Identity Reconciliation](https://projects.glasscliff.online/labs/identity/recon)

## Next Steps

Automated drift detection, policy validation, protected deployments, and eventually expanding Terraform management into Entra ID and Google Cloud Identity.
