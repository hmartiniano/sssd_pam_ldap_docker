build:
	docker build -t sssd_docker .
run: build
	docker run -d -p 9022:22 \
		-v ${PWD}/secret/sssd.conf:/etc/sssd/sssd.conf \
		-v ${PWD}/secret/krb5.conf:/etc/krb5.conf \
		-v ${PWD}/etc/samba.conf:/etc/samba.conf sssd_docker:latest
