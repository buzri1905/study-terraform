# 02 · Variables, Locals, Outputs

**상태:** 미완 (실습 대상)

입력을 어떻게 받고, 어떻게 검증하고, 어떻게 밖으로 내보낼지.

## 목표

`versions.tf` 만 있는 상태에서 시작해, 아래를 모두 쓰는 구성을 직접 작성한다.
리소스는 뭐든 좋다 (S3 + SSM Parameter 조합이 비용 0에 가깝고 무난하다).

## 다룰 것

- 타입 제약: `string` / `number` / `bool` / `list(...)` / `map(...)` / `object({...})`
- `validation` 블록 — 잘못된 입력을 apply 전에 죽이기
- `sensitive = true` 가 plan 출력과 state 에 각각 어떻게 반영되는지
- `nullable`, `default` 가 없는 필수 변수
- `locals` 로 파생값 계산, `for` 표현식과 `merge()`
- `output` 의 `sensitive`, `precondition`
- `terraform.tfvars` / `-var-file` / `TF_VAR_` 환경변수의 우선순위

## 완료 조건

- [ ] `object` 타입 변수 하나 이상, `validation` 하나 이상
- [ ] `terraform.tfvars.example` 를 커밋 (`*.tfvars` 는 gitignore 대상)
- [ ] `sensitive` output 을 만들고 `terraform output -raw` 로 꺼내보기
- [ ] 변수 우선순위 실험 결과를 이 README 하단에 메모
