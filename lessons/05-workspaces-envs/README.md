# 05 · Workspaces vs. Directory-per-Environment

**상태:** 미완 (실습 대상)

dev/prod 를 가르는 두 가지 방식을 다 해보고, 왜 실무에서 후자가 우세한지 직접 판단한다.

## 목표

같은 구성을 (a) workspace 로, (b) 디렉터리 분리로 각각 배포해보고 차이를 기록한다.

## 다룰 것

- `terraform workspace new/select/list`, `terraform.workspace` 참조
- workspace 별 state key 가 백엔드에서 어떻게 갈라지는지 (`env:/<ws>/...`)
- 디렉터리 분리 방식: `envs/dev`, `envs/prod` 가 각자 backend key 를 갖는 구조
- `-var-file=dev.tfvars` 와 `locals` 기반 환경별 분기
- workspace 의 함정: provider 설정·리전·계정이 환경마다 다를 때 무너진다

## 완료 조건

- [ ] 두 방식 모두 apply 성공
- [ ] 백엔드에서 state 객체 키가 어떻게 나뉘는지 확인 (`aws s3 ls`)
- [ ] "이 리포의 `project/` 는 왜 디렉터리 분리를 택했는가" 를 아래에 3줄로 정리
