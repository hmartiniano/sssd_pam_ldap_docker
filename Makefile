build:
	docker build -t sssd_docker .
run: build
	docker run -d -p 9022:22 sssd_docker:latest
