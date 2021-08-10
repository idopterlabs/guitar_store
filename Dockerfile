FROM elixir:1.9.4-alpine AS build

RUN apk add --no-cache build-base npm git python3
WORKDIR /app
RUN mix local.hex --force && \
    mix local.rebar --force

##
## Must be present during buildtime
##
ENV MIX_ENV=prod

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

##
## Needed for the startup script env.sh.eex
##
COPY rel rel

COPY lib lib

RUN mix do compile --warnings-as-errors, release

##
## Release image
##
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

EXPOSE 4000

CMD ["bin/guitar_store", "start"]
##
## Useful for debugging purposes.
## This command keeps the process up and running.
## CMD ["tail", "-f", "/dev/null"]