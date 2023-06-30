FROM elixir:1.15-slim AS build

WORKDIR /app

COPY mix.exs mix.lock ./

RUN mix do deps.get, deps.compile

COPY . .

ENV MIX_ENV=prod
RUN mix release

FROM alpine:3.18 AS app

RUN apk --no-cache add bash

COPY --from=build /app/_build/prod/rel/iris ./

EXPOSE 4000

SHELL ["/bin/bash", "-c"]
CMD ["bin/iris", "start"]
