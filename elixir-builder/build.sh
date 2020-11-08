#! /bin/bash
set -eo pipefail

for tag in run build
do
    docker build . -f "Dockerfile.$tag" -t "rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder:$tag"
    docker push "rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder:$tag"
done

pack create-builder rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder \
    --builder-config ./builder.toml \
    --publish
