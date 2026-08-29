# 03 · State & Remote Backend

**상태:** 미완 (실습 대상)

state 가 실제로 무엇인지, 그리고 로컬에서 S3 로 옮기는 과정.

> 선행: 리포 루트의 `bootstrap/` 을 먼저 apply 해서 state 버킷을 만들어 둘 것.
> `terraform output backend_snippet` 이 여기 붙여넣을 backend 블록을 그대로 뱉는다.

## 목표

로컬 state 로 리소스를 만든 뒤, 그 state 를 S3 백엔드로 **마이그레이션**한다.

## 다룰 것

- `terraform.tfstate` 를 직접 열어보기 — 무엇이 들어있고 왜 커밋하면 안 되는지
- `backend "s3"` + `use_lockfile = true` (Terraform 1.11+ 의 S3 네이티브 락;
  예전 자료에 나오는 `dynamodb_table` 은 더 이상 필요 없다)
- `terraform init -migrate-state` 로 로컬 → S3 이관
- `terraform state list` / `show` / `mv` / `rm`
- `terraform import` 로 콘솔에서 만든 리소스를 state 에 편입
- 두 터미널에서 동시에 apply 를 걸어 락 충돌 관찰

## 완료 조건

- [ ] S3 버킷에 state 객체가 올라갔고 로컬 `terraform.tfstate` 는 비어있음
- [ ] `state mv` 로 리소스 주소를 바꿔도 실제 인프라는 그대로임을 plan 으로 확인
- [ ] 락 충돌 에러 메시지를 실제로 한 번 봄
- [ ] 콘솔에서 수동 생성한 리소스 하나를 import 로 흡수
