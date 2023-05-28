.PHONY: build
build:
	docker build -t ansible-test .

.PHONY: run
run:
	docker run --rm -v $(HOME)/code/dotfiles:/home/cocker/dotfiles -it ansible-test bash 
