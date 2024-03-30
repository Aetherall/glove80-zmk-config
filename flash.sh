#!/bin/bash

lh="/media/aetherall/GLV80LHBOOT"
rh="/media/aetherall/GLV80RHBOOT"

repo="Aetherall/glove80-zmk-config"

rm -f glove80.uf2

# Get the recent runs
runs=`gh run -R $repo list --json "headSha,createdAt,databaseId,status"`

# Get the last run
last=`echo $runs | jq 'sort_by(.createdAt) | reverse | .[0].databaseId'`

# Wait for the last run to finish
gh run -R $repo watch $last

# Get the last run's firmware
gh run -R $repo download $last -n glove80.uf2

echo "Waiting for left hand to be connected..."
while [ ! -d $lh ]; do sleep 1; done

echo "Flashing left hand..."
cp glove80.uf2 $lh

echo "Waiting for right hand to be connected..."
while [ ! -d $rh ]; do sleep 1; done

echo "Flashing right hand..."
cp glove80.uf2 $rh
