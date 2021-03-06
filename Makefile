.PHONY: aarch64-xenial armhf-xenial amd64-xenial amd64-darwin ci amd64-centos7 push
all: build-all
build-all: aarch64-xenial armhf-xenial amd64-xenial amd64-darwin ci amd64-centos7

generic-darwin:
	cd generic/darwin; \
		docker build -t docker-registry.k8s.array21.dev/rust-generic-darwin .

aarch64-xenial:
	cd aarch64/xenial; \
		docker build -t docker-registry.k8s.array21.dev/rust-aarch64-xenial .

aarch64-darwin: generic-darwin
	cd aarch64/darwin; \
		docker build -t docker-registry.k8s.array21.dev/rust-aarch64-darwin .

armhf-xenial:
	cd armhf; \
		docker build -t docker-registry.k8s.array21.dev/rust-armhf-xenial .

amd64-darwin: generic-darwin
	cd x86_64/darwin; \
		docker build -t docker-registry.k8s.array21.dev/rust-amd64-darwin .
	
amd64-xenial:
	cd x86_64/darwin; \
		docker build -t docker-registry.k8s.array21.dev/rust-amd64-xenial .

amd64-centos7:
	cd x86_64/centos7; \
		docker build -t docker-registry.k8s.array21.dev/rust-amd64-centos7 .

ci:
	cd x86_64/ci; \
		docker build -t docker-registry.k8s.array21.dev/rust-base .

push: build-all
	docker push docker-registry.k8s.array21.dev/rust-amd64-darwin
	docker push docker-registry.k8s.array21.dev/rust-amd64-xenial
	docker push docker-registry.k8s.array21.dev/rust-amd64-centos7
	
	docker push docker-registry.k8s.array21.dev/rust-aarch64-xenial
	docker push docker-registry.k8s.array21.dev/rust-aarch64-darwin

	docker push docker-registry.k8s.array21.dev/rust-armhf-xenial
	
	docker push docker-registry.k8s.array21.dev/rust-base
	