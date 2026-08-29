# Final Project · ECS Fargate service on a custom VPC

**상태:** 미완 (lessons 01–07 이후 진행)

lessons 에서 조각으로 배운 것을 하나의 모듈화된 실전 구성으로 합친다.
여기서부터는 **실제 과금이 발생한다** — NAT Gateway, ALB, RDS 가 주요 비용원.

## 목표 아키텍처

```
                    Internet
                       │
                  [ALB : public subnets ]
                       │
              [ECS Fargate : private subnets]
                       │
                  [RDS : isolated subnets]
```

## 디렉터리

| 경로 | 역할 |
|---|---|
| `modules/vpc` | VPC, 3-tier 서브넷, IGW/NAT, 라우팅 |
| `modules/ecs` | 클러스터, task definition, service, ALB, 타깃 그룹 |
| `modules/rds` | 서브넷 그룹, 파라미터 그룹, 인스턴스, Secrets Manager 연동 |
| `envs/dev` | dev 조합 — 단일 NAT, `db.t4g.micro`, desired_count 1 |
| `envs/prod` | prod 조합 — AZ 별 NAT, Multi-AZ RDS, desired_count 2+ |

각 환경은 **자기 backend key 를 갖는 독립 state** 다 (lesson 05 의 결론).

## 규칙

- 모듈은 `provider` 블록을 선언하지 않는다. 루트에서만 설정하고 필요 시 `providers` 로 주입.
- 모듈 간 참조는 반드시 output 을 통해서. 다른 모듈의 리소스를 직접 주소로 참조하지 않는다.
- 모든 변수·출력에 `description`. `make docs` 가 각 모듈 README 를 채운다.
- dev 와 prod 의 차이는 **tfvars 값**으로만 표현한다. 구조가 갈라지기 시작하면 모듈을 잘못 자른 것.

## 비용 관리

```bash
# 하루 실습 끝나면
cd envs/dev && terraform destroy
```

NAT Gateway 는 켜두면 시간당 과금된다. dev 는 `single_nat_gateway = true` 로 시작할 것.
