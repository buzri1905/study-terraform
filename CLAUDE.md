# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A Terraform **learning** repository that doubles as portfolio evidence. Each
concept gets its own directory under `lessons/`, and `project/` combines them
into one modularised AWS deployment. The owner is a DevOps engineer with ~2.5
years of experience — skip Terraform fundamentals in explanations and go
straight to the trade-off being made.

The learning is the point. When a `lessons/` directory is marked
**미완 (실습 대상)** in its README, do not write the solution unless explicitly
asked. Answer questions, review what the user wrote, point at the
documentation, unblock errors — but leave the authoring to them. Lesson 01 is
the one worked example and exists as the reference pattern; treat it as the
style guide the other lessons should converge on.

## Commands

```bash
make validate      # init -backend=false + validate across every .tf directory
make fmt           # terraform fmt -recursive .
make fmt-check     # same, but fails on violation (what CI runs)
make docs          # inject terraform-docs tables into project/modules/*/README.md
make docs-check    # fails if generated docs differ from what is committed
make clean         # remove .terraform caches
```

Single directory, without touching the others:

```bash
terraform -chdir=lessons/01-hello-provider init
terraform -chdir=lessons/01-hello-provider plan
terraform -chdir=lessons/01-hello-provider apply
terraform -chdir=lessons/01-hello-provider destroy
```

Prefer `terraform -chdir=<dir>` over `cd`. The Bash tool's working directory
persists between calls, and a stray `cd` into a lesson silently changes where
every later command lands.

## Layout and why

```
bootstrap/    S3 state bucket. Local state by design (chicken-and-egg).
lessons/NN-*/ One concept each. Self-contained root modules, local state
              until lesson 03 migrates them.
project/      modules/{vpc,ecs,rds} + envs/{dev,prod}. The final target.
```

`project/envs/dev` and `project/envs/prod` are **separate root modules with
separate backend keys**, not workspaces — that is the conclusion lesson 05
exists to reach. Environment differences belong in tfvars values, never in
diverging structure; if a module needs different resources per environment,
the module boundary is wrong.

## Conventions

- **File split:** `versions.tf` (terraform block + provider) · `variables.tf` ·
  `main.tf` · `outputs.tf`. Lesson starters ship only `versions.tf`.
- **Version pinning:** `required_version >= 1.11`, `hashicorp/aws ~> 6.0`.
  `.terraform.lock.hcl` is committed; `.terraform/` is not.
- **Tagging:** every root module sets `provider.default_tags` with
  `Project` / `Lesson` (or `Component`) / `ManagedBy`. Do not repeat those tags
  on individual resources.
- **Region:** `ap-northeast-2`, always via a `region` variable with that default.
- **Naming:** `${var.project}-<purpose>` where `project` defaults to `study-tf`.
  Globally-unique names (S3) get a `random_id` suffix.
- **Modules never declare `provider` blocks.** Configure providers in the root
  and pass them with `providers = {}` when a module needs a non-default one.
- **`for_each` over `count`** unless the resource is genuinely a scalar toggle.
- Every `variable` and `output` needs a `description` — `make docs-check` and
  the CI docs job depend on it.

## State

Terraform 1.11+ S3 native locking is used: `use_lockfile = true` inside
`backend "s3"`. There is no DynamoDB lock table, and none should be added —
older tutorials will say otherwise. The state bucket carries
`prevent_destroy = true`; if a `terraform destroy` in `bootstrap/` is ever
genuinely intended, that lifecycle block has to be removed in a deliberate,
separate commit.

## Secrets and tfvars

`*.tfvars` is gitignored; `*.tfvars.example` is committed. Never write real
account IDs, ARNs with account numbers, or credentials into tracked files.
`aws configure` is the user's to run — it is interactive and handles secrets.

## Cost

This runs against a **real, paid AWS account**, not a free tier. `bootstrap/`
and `lessons/` are effectively free (S3, SSM). `project/` is not: NAT Gateway,
ALB and RDS bill by the hour. When suggesting anything under `project/`,
mention the standing cost, and end multi-step `project/` work by reminding the
user to `terraform destroy`.

## CI

`.github/workflows/terraform.yml` runs `fmt`, `validate` (credential-free via
`-backend=false`) and a `terraform-docs` diff check on every push and PR. The
`plan` job is gated on the repository variable `AWS_ROLE_ARN` and stays skipped
until OIDC is wired up — that is intentional, not a broken job. Keep CI green:
run `make fmt validate docs` before committing.
