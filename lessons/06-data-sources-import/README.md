# 06 · Data Sources, Import & Removed

**상태:** 미완 (실습 대상)

Terraform 이 만들지 않은 것을 참조하고, 흡수하고, 놓아주는 방법.

## 목표

기존 리소스를 data source 로 읽고, `import` 블록으로 관리 대상에 편입하고,
`removed` 블록으로 파괴 없이 관리에서 뺀다.

## 다룰 것

- `data "aws_availability_zones"`, `data "aws_ami"`, `data "aws_caller_identity"`
- `terraform_remote_state` data source 로 다른 구성의 output 읽기
- 선언형 `import { to = ..., id = ... }` 블록 (CLI `terraform import` 와의 차이)
- `terraform plan -generate-config-out=gen.tf` 로 설정 초안 뽑기
- `removed` 블록 — state 에서만 빼고 실물은 남기기
- data source 가 plan 시점에 unknown 이 되는 경우와 그 파급

## 완료 조건

- [ ] 콘솔에서 수동 생성한 리소스를 `import` 블록 + `-generate-config-out` 으로 흡수
- [ ] `removed` 로 뺀 뒤 AWS 콘솔에 실물이 그대로 있는지 확인
- [ ] `terraform_remote_state` 로 `bootstrap/` 의 output 참조
