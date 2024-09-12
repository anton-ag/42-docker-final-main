# base
FROM golang:1.22.0 AS base

# build
FROM base AS build
WORKDIR /src
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /srv/

# final
FROM base
WORKDIR /app
COPY --from=build /srv .
COPY tracker.db .
CMD ["/app/42-docker-final"]
