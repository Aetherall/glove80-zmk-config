#!/bin/bash

lh="/media/$USER/GLV80LHBOOT"
rh="/media/$USER/GLV80RHBOOT"

repo=`git remote -v | grep origin | head -n 1 | awk '{print $2}' | cut -d ':' -f 2 | cut -d '.' -f 1`

rm -rf out

# Get the recent runs
runs=`gh run -R $repo list --json "headSha,createdAt,databaseId,status"`

# Get the last run
last=`echo $runs | jq 'sort_by(.createdAt) | reverse | .[0].databaseId'`

# Wait for the last run to finish
gh run -R $repo watch $last

# Get the last run's firmware
gh run -R $repo download $last -n glove80.uf2 -D out

echo "Waiting for left hand to be connected..."
while [ ! -d $lh ]; do sleep 1; done

echo "Flashing left hand..."
cp out/glove80.uf2 $lh

echo "Waiting for right hand to be connected..."
while [ ! -d $rh ]; do sleep 1; done

echo "Flashing right hand..."
cp out/glove80.uf2 $rh
