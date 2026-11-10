<!-- Title must be a conventional commit — it becomes the squash commit:
     feat: …  |  fix: …  |  docs: …  |  ci: …  |  chore: …  |  refactor: …
     Branch naming: <type>/<short-description>, e.g. feat/networking-module -->

## What

<!-- One or two sentences: what changes and why. -->

## Work item

Closes #

## Verification

<!-- How you confirmed it works: terraform fmt/validate, terraform plan output, CI run, etc. -->

- [ ] `terraform fmt -check -recursive` passes
- [ ] `terraform validate` passes
- [ ] No secrets, credentials or real backend names in the diff
