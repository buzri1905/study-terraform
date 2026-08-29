# 04 · Modules

**상태:** 미완 (실습 대상)

재사용 단위를 어떻게 자르는가. `project/` 로 넘어가기 전의 핵심 관문.

## 목표

로컬 모듈 하나를 직접 작성하고, 같은 모듈을 서로 다른 입력으로 2회 이상 호출한다.

## 다룰 것

- 모듈 인터페이스: 입력(variables) · 출력(outputs) · 내부 구현의 경계
- `source = "./modules/xxx"` 로컬 호출과 레지스트리 호출(`version` 제약)의 차이
- `for_each` 를 모듈에 걸어 N 개 인스턴스 생성
- `count` vs `for_each` — 왜 대부분 `for_each` 가 맞는가
- 모듈 안에서 `provider` 를 선언하면 안 되는 이유, `providers = {}` 로 넘기기
- `terraform-docs` 로 모듈 README 자동 생성 (`make docs`)

## 완료 조건

- [ ] `./modules/<name>/` 에 모듈 작성, 루트에서 `for_each` 로 호출
- [ ] 모든 변수·출력에 `description` 이 있고 `make docs` 가 README 를 채움
- [ ] `terraform graph` 로 의존 관계 확인
