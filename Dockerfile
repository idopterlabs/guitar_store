FROM elixir:1.9.4-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python3

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod
ENV IS_LOCAL=${IS_LOCAL:-false}

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets

RUN npm run --prefix ./assets deploy
RUN mix phx.digest

COPY lib lib

# Needed for the startup script env.sh.eex
COPY rel rel

RUN mix do compile, release

# Prepare Release image
FROM alpine:3.9 AS app
RUN apk add --no-cache openssl ncurses-libs
##
## Adds telnet and curl, useful for debugging
## RUN apk add busybox-extras curl
##
WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/guitar_store ./

ENV HOME=/app

CMD ["bin/guitar_store", "start"]
#CMD ["tail", "-f", "/dev/null"]