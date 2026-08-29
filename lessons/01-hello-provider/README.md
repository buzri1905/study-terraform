# 01 · Hello, Provider

**상태:** 예제 완성 (나머지 실습의 기준 패턴)

첫 `init → plan → apply → destroy` 사이클을 도는 최소 구성. 파일 분리 관례
(`versions.tf` / `variables.tf` / `main.tf` / `outputs.tf`)와 암묵적 의존성
그래프가 어떻게 만들어지는지를 보여준다.

## 다루는 것

- `required_version` / `required_providers` 로 버전 고정, `.terraform.lock.hcl` 커밋
- `provider "aws"` 의 `default_tags` — 리소스마다 태그를 반복하지 않기
- 속성 참조(`aws_s3_bucket.hello.id`)로 만들어지는 암묵적 의존성
- `lifecycle { ignore_changes }` 로 매 plan 마다 dirty 해지는 값 잠재우기
- `output` 으로 다른 구성에 넘길 값 노출

## 실행

```bash
terraform init
terraform plan
terraform apply
terraform destroy
```

## 확인할 것

- [ ] `terraform plan` 을 두 번 연속 실행했을 때 두 번째가 `No changes` 인가
- [ ] `terraform state list` 에 리소스 4개가 보이는가
- [ ] `random_id` 를 지우고 다시 apply 하면 버킷이 교체(replace)되는 이유 설명 가능한가
- [ ] `ignore_changes` 를 빼면 plan 이 어떻게 달라지는가
