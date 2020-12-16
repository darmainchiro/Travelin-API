include .env

start-db:
	docker start ${PROJECT_NAME}-${BRANCH}-${VERSION}-db

stop-db:
	docker stop ${PROJECT_NAME}-${BRANCH}-${VERSION}-db

shell-db:
	docker exec -it ${PROJECT_NAME}-${BRANCH}-${VERSION}-db mysql -u ${DB_USERNAME} -p${DB_PASSWORD} ${DB_DATABASE}

run-db:
	docker run --name ${PROJECT_NAME}-${BRANCH}-${VERSION}-db \
	    -e MYSQL_ROOT_PASSWORD=${DB_ROOT_PASS} \
		-e MYSQL_DATABASE=${DB_DATABASE} \
		-e MYSQL_USER=${DB_USERNAME} \
		-e MYSQL_PASSWORD=${DB_PASSWORD} \
		-d mariadb:10.2-bionic

run-phpmyadmin:
	docker run --name ${PROJECT_NAME}-${BRANCH}-${VERSION}-phpmyadmin \
	-d --link ${PROJECT_NAME}-${BRANCH}-${VERSION}-db:db \
	-p 8080:80 \
	 phpmyadmin

build-dev:
	docker build -t ${PROJECT_NAME}/${BRANCH}:${VERSION} .

run-dev:
	docker run --name ${PROJECT_NAME}-${BRANCH}-${VERSION}-apps \
		--rm \
		-it \
		-p 8080:80 \
		--link ${PROJECT_NAME}-${BRANCH}-${VERSION}-db:dbhost \
		-v ${PWD}/:/apps/ \
		${PROJECT_NAME}/${BRANCH}:${VERSION}

run-daemon-dev:
	docker run --name ${PROJECT_NAME}-${BRANCH}-${VERSION}-apps \
		--rm \
		-it \
		-d \
		-p 8080:80 \
		--link ${PROJECT_NAME}-${BRANCH}-${VERSION}-db:dbhost \
		-v ${PWD}/:/apps/ \
		${PROJECT_NAME}/${BRANCH}:${VERSION}

make stop-daemon-dev:
	docker stop ${PROJECT_NAME}/${BRANCH}:${VERSION}

make restart-daemon-dev: stop-daemon-dev run-daemon-dev

run-shell-dev:
	docker run --name ${PROJECT_NAME}-${BRANCH}-${VERSION}-apps \
		--rm \
		-it \
		-p 8080:80 \
		--link ${PROJECT_NAME}-${BRANCH}-${VERSION}-db:dbhost \
		-v ${PWD}/:/apps/ \
		${PROJECT_NAME}/${BRANCH}:${VERSION} /bin/bash
