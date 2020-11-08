# elixir-buildpacks

A collection of buildpacks to build images of elixir projects

1. `erlang-runtime`
1. `elixir-runtime`
1. `mix-release` download project dependencies and create an [Elixir Release](https://elixir-lang.org/blog/2019/06/24/elixir-v1-9-0-released/#releases)
1. `elixir` meta buildpack that define the order in which buildpack run

In addition `rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder` is a builder based on `ubuntu:bionic` including the 4 buildpacks.

This stack support `org.cloudfoundry.stacks.cflinuxfs3` (`cloudfoundry/cnb:cflinuxfs3`) and `io.github.carlo-colombo.elixir-builder`

### Know limitations

* It at least partially support `phoenix`, it requires to pass in `SECRET_KEY_BASE` as environment variable. For example

```bash
pack build dashboard \
  --path . \
  --builder rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder \
  -e DEBUG=1 \
  -e SECRET_KEY_BASE="$(mix phx.gen.secret)"
```

## How to build an image with pack

### Using the builder image

```bash
pack build <elixir project image> \
  --path <elixir project> \
  --builder rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder
```

### Using individual buildpacks

```bash
pack build <elixir project image> \
  --path <elixir project> \
  --buildpack ./elixir/  \
  -b ./elixir-runtime/ \
  -b ./erlang-runtime/ \
  -b ./mix-release/ \
  --builder rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder
```

## How to create the builder image

```bash
cd elixir-builder
./build.sh
```

It create an image on the local docker named `rg.nl-ams.scw.cloud/carlo-colombo/elixir-builder`
