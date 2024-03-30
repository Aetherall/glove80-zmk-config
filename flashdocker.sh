#!/bin/bash

lh="/media/$USER/GLV80LHBOOT"
rh="/media/$USER/GLV80RHBOOT"

sudo rm -rf out/glove80.uf2

# docker buildx build --progress plain -t moergozmk .

docker run -it \
  -v $(pwd)/config:/workspace/config \
  -v $(pwd)/out:/workspace/out \
  moergozmk

sudo chown -R $USER:$USER out

echo "Waiting for left hand to be connected..."
while [ ! -d $lh ]; do sleep 1; done

echo "Flashing left hand..."
cp out/glove80.uf2 $lh

echo "Waiting for right hand to be connected..."
while [ ! -d $rh ]; do sleep 1; done

echo "Flashing right hand..."
cp out/glove80.uf2 $rh
