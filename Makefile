APP_NAME=mr
LISP_FILES=$(shell find . -name '*.lisp')
ASDF_TREE ?= ~/quicklisp/
DIST_FOLDER ?= dist
APP_OUT=$(DIST_FOLDER)/$(APP_NAME)
QL_LOCAL=$(PWD)/.quicklocal/quicklisp
QUICKLISP_SCRIPT=http://beta.quicklisp.org/quicklisp.lisp
LOCAL_OPTS=--noinform --noprint --disable-debugger --no-sysinit --no-userinit
QL_OPTS=--load $(QL_LOCAL)/setup.lisp
LISP ?= sbcl
SOURCES := $(wildcard src/*.lisp) $(wildcard *.asd)
BUILDAPP = ./bin/buildapp
PWD=$(shell pwd)

.PHONY: clean docker-create docker-start docker-stop

all: $(APP_OUT)

bin:
	@mkdir bin


clean:
	@-yes | rm -rf $(QL_LOCAL)
	@-rm -f $(APP_OUT) deps install-deps

$(QL_LOCAL)/setup.lisp:
	@curl -O $(QUICKLISP_SCRIPT)
	@sbcl $(LOCAL_OPTS) \
		--load quicklisp.lisp \
		--eval '(quicklisp-quickstart:install :path "$(QL_LOCAL)")' \
		--eval '(quit)'

deps:
	@sbcl $(LOCAL_OPTS) $(QL_OPTS) \
	     --eval '(push "$(PWD)/" asdf:*central-registry*)' \
	     --eval '(ql:quickload :mr)' \
	     --eval '(quit)'
	@touch $@

install-deps: $(QL_LOCAL)/setup.lisp deps
	@touch $@

bin/buildapp: bin $(QL_LOCAL)/setup.lisp
	@cd $(shell sbcl $(LOCAL_OPTS) $(QL_OPTS) \
				--eval '(ql:quickload :buildapp :silent t)' \
				--eval '(format t "~A~%" (asdf:system-source-directory :buildapp))' \
				--eval '(quit)') && \
	$(MAKE) DESTDIR=$(PWD) install

$(APP_OUT): $(SOURCES) bin/buildapp $(QL_LOCAL)/setup.lisp install-deps
	@mkdir -p $(DIST_FOLDER)
	@$(BUILDAPP) --logfile /tmp/build.log \
			--sbcl sbcl \
			--asdf-path . \
			--asdf-tree $(QL_LOCAL)/local-projects \
			--asdf-tree $(QL_LOCAL)/dists \
			--asdf-path . \
			--load-system $(APP_NAME) \
			--entry $(APP_NAME)::main \
			--output $(APP_OUT)

docker-create:
	@docker build -t ralt/mr_web .
	@docker run --volume=/var/lib/postgresql/data --env="POSTGRES_PASSWORD=password" --env="POSTGRES_USER=mr" --name=mr_postgres postgres &
	@docker run --volume="$(PWD):/root/common-lisp/mr" --env="DBNAME=postgres" --env="DBUSER=mr" --env="DBPASS=password" --env="DBHOST=db" --link="mr_postgres:db" --publish="4242:4242" --publish="5555:4005" --name="mr_web" ralt/mr &
	@echo "mr_postgres and mr_web created and running!"

docker-start:
	@echo "Starting mr_postgres and mr_web..."
	@docker start mr_postgres > /dev/null
	@docker start mr_web > /dev/null
	@echo "mr_postgres and mr_web started."

docker-stop:
	@echo "Stopping mr_postgres and mr_web..."
	@docker stop mr_web > /dev/null
	@docker stop mr_postgres > /dev/null
	@echo "mr_postgres and mr_web stopped."
