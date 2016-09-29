#!/bin/bash

BASE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../ && pwd )"
COMMITS=$(git log master..HEAD --pretty=format:%H)
TMP=${TMPDIR-/tmp/}

RET=0

for COMMIT in $COMMITS
do
  TMPFILE=`mktemp $TMPDIR/commit-msg.XXXXXX`
  git log --format=%B -n 1 $COMMIT > $TMPFILE
  $BASE/node_modules/.bin/validate-commit-msg $TMPFILE
  LAST=$?
  RET=$((RET+LAST))
done

exit $RET
