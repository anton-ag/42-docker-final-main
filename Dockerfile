# base
FROM golang:1.22.0 AS base
WORKDIR /app

# build
FROM base AS build
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN go build

# final
FROM base
COPY --from=build /app .
COPY tracker.db .
CMD ["/app/42-docker-final"]
