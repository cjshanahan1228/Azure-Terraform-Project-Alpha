# CI

The Terraform pipeline lives at [`.github/workflows/terraform.yml`](../.github/workflows/terraform.yml),
not in this folder: GitHub Actions only loads workflows from `.github/workflows/`.
This folder is the place for CI notes and any helper scripts.

## What it does

| Trigger | Environment | Steps |
| --- | --- | --- |
| `pull_request` to `main` | `dev` | fmt → init → validate → plan |
| `workflow_dispatch` | `dev` (default), `staging` or `prod` | fmt → init → validate → plan |

1. `terraform fmt -check -recursive`
2. `terraform init -backend=false` + `terraform validate`: credential-free, always runs.
3. `terraform init -backend-config=environments/<env>/backend.hcl` + `terraform plan -var-file=environments/<env>/<env>.tfvars`:
   runs only when the credentials and backend are ready (below). It never applies.

## Turning on plan

1. Create the state storage for the environment and fill in `environments/<env>/backend.hcl`
   (remove every `REPLACE_ME`).
2. Add these repository secrets (**Settings → Secrets and variables → Actions**):
   `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`, `ARM_SUBSCRIPTION_ID`, `ARM_TENANT_ID`.
3. The service principal needs **Reader** on the subscription (plan only) and
   **Storage Blob Data Contributor** on the state container (state locking writes a lease).

Until both are in place the plan steps are skipped with a notice and the check stays green.

## Recommended upgrade: OIDC

A client secret is a long-lived credential. Prefer **OIDC workload identity federation**:
add a federated credential for this repo to an Entra app or user-assigned managed identity,
give the job `permissions: id-token: write`, set `ARM_USE_OIDC=true`, and drop
`ARM_CLIENT_SECRET`. That's how `colinshanahan.dev-portfolio` signs in.

## Conventions

- Every action is pinned to a full commit SHA with a `# vX.Y.Z` comment; Dependabot
  (`.github/dependabot.yml`) bumps them weekly.
- `permissions: contents: read` only.
