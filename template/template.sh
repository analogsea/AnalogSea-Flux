#!/bin/bash
cd "${0%/*}"

if [[ $# -eq 0 ]] ; then
    echo 'Usage: template.sh <suffix> <namespace>'
    exit 0
fi

SUFFIX=$1

if [[ $# -eq 2 ]] ; then
  NAMESPACE=$2
else
  NAMESPACE=$1
fi

echo $NAMESPACE

export SUFFIX NAMESPACE
mkdir -p runescrape-$SUFFIX:runescrape-$NAMESPACE

cd templates
for DIRECTORY in $(find . -type d); do
  LOCATION=$(echo $DIRECTORY | sed "s/template/$SUFFIX/g")
  mkdir -p "../runescrape-$SUFFIX:runescrape-$NAMESPACE/$LOCATION"
done

for FILE in $(find . -type f); do
  echo $FILE
  LOCATION=$(echo $FILE | sed "s/template/$SUFFIX/g")
  cat $FILE | envsubst > "../runescrape-$SUFFIX:runescrape-$NAMESPACE/$LOCATION";
done
