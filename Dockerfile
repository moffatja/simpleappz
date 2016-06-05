# Start from a Debian image with the latest Alpine version of Go installed
# and a workspace (GOPATH) configured at /go.
FROM golang:alpine

MAINTAINER jmoffat@cisco.com

# Copy the local package files to the container's workspace.
ADD . /go/src/github.com/moffatja/simpleappz

RUN apk add --no-cache git \
    && go get github.com/CiscoZeus/go-zeusclient \
    && apk del git

# Build the outyet command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN go install github.com/moffatja/simpleappz

# Run the outyet command by default when the container starts.
ENTRYPOINT /go/bin/simpleappz

# Document that the service listens on port 9090.
EXPOSE 9090
