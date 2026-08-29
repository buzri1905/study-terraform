# study-terraform

[![terraform](https://github.com/buzri1905/study-terraform/actions/workflows/terraform.yml/badge.svg)](https://github.com/buzri1905/study-terraform/actions/workflows/terraform.yml)

Terraform 실습 기록. 개념 하나당 디렉터리 하나로 쌓고, 마지막에 하나의 모듈화된
AWS 구성으로 합친다. 모든 커밋은 `fmt` · `validate` · `terraform-docs` CI 를 통과한다.

- **Provider:** AWS (`hashicorp/aws ~> 6.0`), 기본 리전 `ap-northeast-2`
- **Terraform:** `>= 1.11` (S3 네이티브 state 락 `use_lockfile` 사용, DynamoDB 불필요)
- **State:** `bootstrap/` 이 만든 S3 버킷 (버저닝 + SSE + 90일 이전 버전 만료)

## 진행 현황

| # | 주제 | 상태 |
|---|---|---|
| — | [`bootstrap/`](bootstrap) — state 백엔드 부트스트랩 | ✅ 코드 완성 |
| 01 | [Hello, Provider](lessons/01-hello-provider) | ✅ 완료 |
| 02 | [Variables, Locals, Outputs](lessons/02-variables-outputs) | ⬜ |
| 03 | [State & Remote Backend](lessons/03-state-remote-backend) | ⬜ |
| 04 | [Modules](lessons/04-modules) | ⬜ |
| 05 | [Workspaces vs. Dir-per-Env](lessons/05-workspaces-envs) | ⬜ |
| 06 | [Data Sources, Import & Removed](lessons/06-data-sources-import) | ⬜ |
| 07 | [Lifecycle, Moved & Provisioners](lessons/07-lifecycle-provisioner) | ⬜ |
| — | [`project/`](project) — VPC + ECS Fargate + RDS | ⬜ |

## 시작하기

```bash
# 1. 자격 증명 (한 번만)
aws configure                       # 또는 aws configure sso
aws sts get-caller-identity         # 확인

# 2. state 백엔드 생성 (한 번만)
terraform -chdir=bootstrap init
terraform -chdir=bootstrap apply
terraform -chdir=bootstrap output backend_snippet   # 03 에 붙여넣을 backend 블록

# 3. 첫 실습
terraform -chdir=lessons/01-hello-provider init
terraform -chdir=lessons/01-hello-provider apply
terraform -chdir=lessons/01-hello-provider destroy  # 끝나면 반드시
```

## 자주 쓰는 명령

```bash
make help          # 타깃 목록
make fmt           # 전체 포맷
make validate      # 전 디렉터리 init -backend=false + validate
make docs          # project/modules/* README 에 terraform-docs 주입
make clean         # .terraform 캐시 제거
```

## 비용

`bootstrap/` 과 `lessons/` 는 S3·SSM 위주라 사실상 0원이다.
`project/` 는 NAT Gateway·ALB·RDS 때문에 **켜둔 시간만큼 과금**된다.
실습이 끝나면 해당 디렉터리에서 `terraform destroy` 를 도는 것을 습관으로 둘 것.
