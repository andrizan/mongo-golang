FROM golang:alpine AS builder
# Set Go env
ENV CGO_ENABLED=0 GOOS=linux

WORKDIR /go/src

# Install dependencies
RUN apk --update --no-cache add ca-certificates gcc libtool make musl-dev git openssh-client

# Build Go binary
# COPY Makefile go.mod go.sum ./
COPY go.mod go.sum ./

RUN --mount=type=cache,mode=0755,target=/go/pkg/mod go mod download

COPY . .

RUN --mount=type=cache,target=/root/.cache/go-build --mount=type=cache,mode=0755,target=/go/pkg/mod go mod tidy && go build -o mongo-app *.go

# Deployment container
FROM scratch

COPY --from=builder /go/src/mongo-app /mongo-app

ENTRYPOINT ["/mongo-app"]
CMD []
