docker buildx build --progress plain -t moergozmk .

docker run -it \
  -v $(pwd)/config:/workspace/config \
  -v $(pwd)/out:/workspace/out \
  moergozmk