# env
export MYSQL_ROOT_PASSWORD=123456
export BASE_INFO_API_URL=http://backend-base:8081
export IMAGE_PREFIX=

# path
export BACKEND_BASE=repo-group1-base/backend/
export BACKEND_COURSE=repo-group2-course/backend/
export FRONTEND_BASE=repo-group1-base/frontend/
export FRONTEND_COURSE=repo-group2-course/frontend/
export GATEWAY=repo-infrastructure/gateway/
export INIT_SQL=repo-infrastructure/init.sql
export DOCKER_STACK=repo-infrastructure/docker-stack.yml

SWARM_SCRIPTS_PATH=repo-infrastructure/scripts/

.PHONY: all
all: build
	@bash ${SWARM_SCRIPTS_PATH}load.sh
	@bash ${SWARM_SCRIPTS_PATH}deploy.sh

.PHONY: build
build: swarmEnable
	@if ! docker image inspect mysql:8.0 &> /dev/null; then \
		echo "Pulling mysql:8.0..."; \
		docker pull mysql:8.0; \
	fi
	@bash ${SWARM_SCRIPTS_PATH}build.sh

.PHONY: swarmEnable
swarmEnable: 
	@bash ${SWARM_SCRIPTS_PATH}swarm_enable.sh

.PHONY: clean
clean:
	@bash ${SWARM_SCRIPTS_PATH}swarm_rm.sh
	@bash ${SWARM_SCRIPTS_PATH}clean.sh
