# 07 · Lifecycle, Moved & the Provisioner Trap

**상태:** 미완 (실습 대상)

교체 순서를 통제하고, 리팩터링을 파괴 없이 하고, provisioner 를 왜 피하는지 안다.

## 목표

리소스 교체가 다운타임을 만드는 상황을 재현하고 `create_before_destroy` 로 없앤다.

## 다룰 것

- `create_before_destroy` — 왜 이름 충돌(`name_prefix`)을 같이 다뤄야 하는지
- `prevent_destroy` — `bootstrap/` 의 state 버킷에 이미 걸려있음
- `ignore_changes` 와 그 남용의 대가
- `replace_triggered_by` 로 다른 리소스 변경 시 강제 교체
- `moved` 블록으로 리소스 주소 변경을 plan 에 no-op 으로 보이게 하기
- `terraform_data` (구 `null_resource`) 와 `provisioner` — 마지막 수단인 이유,
  `local-exec` / `remote-exec` 가 state 와 어긋나는 지점

## 완료 조건

- [ ] `create_before_destroy` 유무에 따른 plan 순서 차이를 캡처
- [ ] 리소스 이름을 바꾸고 `moved` 로 plan 을 `No changes` 로 만들기
- [ ] `prevent_destroy` 가 걸린 리소스에 destroy 를 시도해 에러 확인
