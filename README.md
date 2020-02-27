# elixir-buildpacks

A collection of buildpacks to build images of elixir projects

1. `erlang-runtime`
1. `elixir-runtime`
1. `mix-release` download project dependencies and create an [Elixir Release](https://elixir-lang.org/blog/2019/06/24/elixir-v1-9-0-released/#releases)
1. `elixir` meta buildpack that define the order in which buildpack run

In addition `carlocolombo/elixir-builder` is a builder based on `ubuntu:bionic` including the 4 buildpacks.

This stack support `org.cloudfoundry.stacks.cflinuxfs3` (`cloudfoundry/cnb:cflinuxfs3`) and `io.github.carlo-colombo.elixir-builder`

## How to build an image with pack

### Using the builder image

```bash
pack build <elixir project image> \
  --path <elixir project> \
  --builder carlocolombo/elixir-builder
```

### Using individual buildpacks

```bash
pack build <elixir project image> \
  --path <elixir project> \
  --buildpack ./elixir/  \
  -b ./elixir-runtime/ \
  -b ./erlang-runtime/ \
  -b ./mix-release/ \
  --builder carlocolombo/elixir-builder
```

## How to create the builder image

```bash
cd elixir-builder
./build.sh
```

It create an image on the local docker named `carlocolombo/elixir-builder`
