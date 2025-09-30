.PHONY: init
init:
	@mkdir jenkins/data
	@chmod -R 777 jenkins
	@mkdir nexus/data/nexus-data
	@chmod -R 777 nexus
	@mkdir coder-pg-data
	@mkdir gitea-pg-data
	@mkdir coder-home
	@curl -JjLOk https://nexus.niuquery.com:8443/repository/raw-local/softs/tools/coder/cache/coder-cache.tar.gz
	@tar -zxf coder-cache.tar.gz
	@rm -f coder-cache.tar.gz
	@curl -JjLOk https://nexus.niuquery.com:8443/repository/raw-local/softs/tools/coder/providers/coder-terraform-providers.tar.gz
	@tar -zxf coder-terraform-providers.tar.gz
	@rm -f coder-terraform-providers.tar.gz
	@curl -JjLOk https://nexus.niuquery.com:8443/repository/raw-local/softs/tools/coder/code-server/4.104.0/amd64/code-server-tmp.tar.gz
	@tar -zxf code-server-tmp.tar.gz
	@rm -f code-server-tmp.tar.gz

.PHONY: boot
boot:
	docker-compose -f docker-compose.yaml up -d

.PHONY: all
all: init boot
