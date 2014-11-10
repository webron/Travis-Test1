#!/bin/bash

git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"
git config --global push.default simple

git remote set-url origin "https://${GH_TOKEN}@github.com/webron/Travis-Test1.git"

# git checkout master

echo git rev-list --count HEAD -- $SCHEMA
git rev-list --count HEAD -- $SCHEMA
git rev-list HEAD -- $SCHEMA
git rev-list --count HEAD -- schema.json
git rev-list --max-count=99 --count HEAD -- schema.json
git rev-list --sparse --count HEAD -- schema.json
git rev-list --full-history --count HEAD -- schema.json
git rev-list --all --count HEAD -- schema.json
git rev-list --ignore-missing --count HEAD -- schema.json
git rev-list --left-right --count HEAD -- schema.json

NEW_REVISION=`git rev-list --count HEAD -- $SCHEMA`
CURRENT_REVISION=`jq .revision $SCHEMA`

if [ "$CURRENT_REVISION" = "null" ] || [ "$CURRENT_REVISION" = "" ]; then
	CURRENT_REVISION=0
fi

echo "New revision: " $NEW_REVISION
echo "Current revision: " $CURRENT_REVISION

if [ "$NEW_REVISION" -gt "$CURRENT_REVISION" ]; then
	NEW_SCHEMA=`jq .revision=$NEW_REVISION+1 $SCHEMA`
	echo "$NEW_SCHEMA" > $SCHEMA

	let "NEW_REVISION++"

	git commit -m 'Updated schema revision to '"$NEW_REVISION"$'\n\n''[skip ci]' $SCHEMA

	export SCHEMA_MODIFIED=true
	export NEW_REVISION

	echo Current git revision:
	git rev-list --count HEAD -- $SCHEMA
fi

jq .revision $SCHEMA