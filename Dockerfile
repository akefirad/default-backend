FROM golang:1.14-alpine as builder

WORKDIR /src
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags '-w -s' -o main main.go

FROM scratch

COPY --from=builder /src/main /
COPY 404.html .

CMD ["/main"]