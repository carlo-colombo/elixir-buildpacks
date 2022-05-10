#! /bin/bash
set -eo pipefail

[ -z "$DEBUG" ] || set -x

ERLANG_VERSION="24.3.3-1"
ELIXIR_VERSION="v1.13.4"

set +e

mkdir ./packages

wget "https://packages.erlang-solutions.com/erlang/debian/pool/esl-erlang_${ERLANG_VERSION}~ubuntu~bionic_amd64.deb" .\
    -O ./packages/erlang \
    --no-clobber
wget "https://github.com/elixir-lang/elixir/releases/download/${ELIXIR_VERSION}/Precompiled.zip" \
    -O ./packages/elixir \
    --no-clobber
set -e

for tag in run build
do
    docker build . -f "Dockerfile.$tag" -t "rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder:$tag"
    docker push "rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder:$tag"
done

pack builder create rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder \
    --config ./builder.toml \
    --publish
