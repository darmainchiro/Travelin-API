include .env

start-db:
	docker start ${BRANCH}-${VERSION}-db

stop-db:
	docker stop ${BRANCH}-${VERSION}-db

shell-db:
	docker exec -it ${BRANCH}-${VERSION}-db mysql -u ${DB_USERNAME} -p${DB_PASSWORD} ${DB_DATABASE}

run-db:
	docker run --name ${BRANCH}-${VERSION}-db \
	    -e MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS} \
		-e MYSQL_DATABASE=${DB_DATABASE} \
		-e MYSQL_USER=${DB_USERNAME} \
		-e MYSQL_PASSWORD=${DB_PASSWORD} \
		-d mariadb:10.2-bionic

build-dev:
	docker build -t ${PROJECT_NAME}/${BRANCH}:${VERSION} .

run-dev:
	docker run --name ${BRANCH}-${VERSION}-apps \
		--rm \
		-it \
		-p 8080:80 \
		--link ${BRANCH}-${VERSION}-db:dbhost \
		-v ${PWD}/:/apps/ \
		${PROJECT_NAME}/${BRANCH}:${VERSION}

run-daemon-dev:
	docker run --name ${BRANCH}-${VERSION}-apps \
		--rm \
		-it \
		-d \
		-p 8080:80 \
		--link ${BRANCH}-${VERSION}-db:dbhost \
		-v ${PWD}/:/apps/ \
		${PROJECT_NAME}/${BRANCH}:${VERSION}

run-shell-dev:
	docker run --name ${BRANCH}-${VERSION}-apps \
		--rm \
		-it \
		-p 8080:80 \
		--link ${BRANCH}-${VERSION}-db:dbhost \
		-v ${PWD}/:/apps/ \
		${PROJECT_NAME}/${BRANCH}:${VERSION} /bin/bash
