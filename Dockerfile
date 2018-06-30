FROM golang:latest as builder
ADD . /go/src/github.com/kprav33n/berlioz-go-app
RUN go get -u github.com/golang/dep/cmd/dep
WORKDIR /go/src/github.com/kprav33n/berlioz-go-app
RUN dep ensure
RUN go build .

FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=builder /go/src/github.com/kprav33n/berlioz-go-app/berlioz-go-app app
CMD ["./app"]
