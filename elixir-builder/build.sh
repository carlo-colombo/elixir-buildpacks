#! /bin/bash
set -eo pipefail

for tag in run build
do
    docker build . -f "Dockerfile.$tag" -t "carlocolombo/elixir-builder:$tag"
done

pack create-builder carlocolombo/elixir-builder --builder-config ./builder.toml