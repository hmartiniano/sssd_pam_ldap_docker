build:
	docker build -t sssd_docker -f Dockerfile.debug .
run: build
	docker run -d --name sssd \
		--dns 10.121.52.14 \
		-p 9022:22 \
		-p 135:135 \
		-p 137:137 \
		-p 138:138 \
		-p 139:139 \
		-p 445:445 \
		sssd_docker:latest
