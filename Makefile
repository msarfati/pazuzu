# Pazuzu by Michael Sarfati

SHELL=/bin/bash
PROJECT_NAME=pazuzu
MOD_NAME=pazuzu
TEST_CMD=SETTINGS=$$PWD/etc/testing.conf nosetests -w $(MOD_NAME)
TEST_DUMP="./maketests.log"

install:
	python setup.py install

clean:
	rm -rf build dist *.egg-info
	#find $$PWD -name '__pycache__' -exec chflags hidden {} \;
 	#grep -E "(__pycache__|\.pyc$)" | xargs rm -rf
#	find $$PWD -path '*/__pycache__/*' -delete
#	find $$PWD -type d -path '__pycache__' -empty -delete

server:
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py runserver

shell:
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py shell

watch:
	watchmedo shell-command -R -p "*.py" -c 'echo \\n\\n\\n\\nSTART; date; $(TEST_CMD) -c etc/nose/test-single.cfg; date' .

test:
	rm -f $(TEST_DUMP)
	$(TEST_CMD) -c etc/nose/test.cfg 2>&1 | tee -a $(TEST_DUMP)

single:
	$(TEST_CMD) -c etc/nose/test-single.cfg 2>&1 | tee -a makesingle.log

upgrade:
	git fetch -f
	HL7_DAEMON_SERVER_PID="`ps -elf | grep -e '[h]l7-daemon.*runserver' | awk '{print $4}'`"
	if [ $$HL7_DAEMON_SERVER_PID ]; then kill -9 $$HL7_DAEMON_SERVER_PID; fi;
	make install
	make docs
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py db upgrade
	if [ $$HL7_DAEMON_SERVER_PID ]; then make server; fi;


db:
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py init_db
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py populate_db

dbshell:
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py dbshell

upgradedb:
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py db upgrade

migratedb:
	SETTINGS=$$PWD/etc/dev.conf bin/manage.py db migrate

docs:
	# Docs located in var/sphinx/build/
	rm -rf etc/sphinx/api var/sphinx/api
	mkdir -p var/sphinx/api/$(MOD_NAME)
	sphinx-apidoc --separate -o var/sphinx/api/$(MOD_NAME) $(MOD_NAME) $(MOD_NAME)/tests
	ln -s $$PWD/var/sphinx/api etc/sphinx/api
	SETTINGS=$$PWD/etc/dev.conf sphinx-build -b html etc/sphinx var/sphinx/build
	rm etc/sphinx/api

gh-pages: docs
	rm -rf /tmp/gh-pages
	git clone -b gh-pages {{ git_repo }} /tmp/gh-pages
	cp -r var/sphinx/build /tmp/gh-pages
	cd /tmp/gh-pages && git add -A && git commit -am "autosync documentation" && git push -u origin gh-pages

test-server:
	SETTINGS=$$PWD/etc/testing.conf bin/manage.py init_db
	SETTINGS=$$PWD/etc/testing.conf bin/manage.py populate_db
	SETTINGS=$$PWD/etc/testing.conf bin/manage.py fixtures
	SETTINGS=$$PWD/etc/testing.conf bin/manage.py runserver

notebook:
	SETTINGS=$$PWD/etc/dev.conf cd var/ipython && ipython notebook

deps-linux:
	pip install wheelhouse/pysqlite-2.6.3-cp27-none-linux_x86_64.whl


.PHONY: clean install test server watch notebook db single docs shell upgradedb migratedb mllp-daemon dbshell boxcryptor test-server deps-linux upgrade
