# Terraform directories that hold a root or child module.
TF_DIRS := $(shell find bootstrap lessons project -name '*.tf' -exec dirname {} \; | sort -u)
DOC_DIRS := $(wildcard project/modules/*)

.PHONY: help fmt fmt-check validate docs docs-check clean

help: ## 사용 가능한 타깃 표시
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-12s\033[0m %s\n", $$1, $$2}'

fmt: ## 모든 .tf 파일 포맷
	terraform fmt -recursive .

fmt-check: ## 포맷 위반 시 실패 (CI용)
	terraform fmt -recursive -check -diff .

validate: ## 모든 디렉터리에서 init -backend=false + validate
	@set -e; for d in $(TF_DIRS); do \
		echo "==> $$d"; \
		terraform -chdir=$$d init -backend=false -input=false -no-color > /dev/null; \
		terraform -chdir=$$d validate -no-color; \
	done

docs: ## project/modules/* 의 README 에 terraform-docs 주입
	@for d in $(DOC_DIRS); do \
		echo "==> $$d"; \
		terraform-docs --config .terraform-docs.yml "$$d"; \
	done

docs-check: ## 생성된 문서가 커밋과 다르면 실패 (CI용)
	@$(MAKE) --no-print-directory docs
	@git diff --exit-code -- '*/README.md' \
		|| { echo "terraform-docs 결과가 커밋과 다릅니다. 'make docs' 후 커밋하세요."; exit 1; }

clean: ## .terraform 캐시 제거
	find . -type d -name '.terraform' -prune -exec rm -rf {} +
