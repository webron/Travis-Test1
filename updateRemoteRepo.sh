#!/bin/bash
  
if [ "$SCHEMA_MODIFIED" = true ]; then
#if [ true ]; then
	pwd
	cd ..
	git clone https://github.com/webron/Travis-Test-Remote.git
	cd Travis-Test-Remote

	git remote set-url origin "https://${GH_TOKEN}@github.com/webron/Travis-Test-Remote.git"

	cp "../Travis-Test/$SCHEMA" ./

	ls -la

	git add .
	git commit -m 'Updated schema revision to '"$NEW_REVISION"


	git push
fi