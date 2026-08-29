# envs/prod

**상태:** 미완

이 디렉터리는 `prod` 환경의 루트 모듈이다. 여기 들어갈 것:

- `versions.tf` — `backend "s3"` (key: `project/prod/terraform.tfstate`) + provider
- `main.tf` — `../../modules/{vpc,ecs,rds}` 호출과 모듈 간 배선
- `prod.tfvars.example` — 환경별 값 (실제 `.tfvars` 는 gitignore)
- `outputs.tf` — ALB DNS 등 확인용 출력
