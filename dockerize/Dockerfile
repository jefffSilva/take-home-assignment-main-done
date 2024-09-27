
FROM golang:1.20 AS builder

WORKDIR /app

COPY webserver/go.mod webserver/go.sum ./


RUN go mod download
 
COPY webserver/ .

ENV GOOS=linux GOARCH=amd64

# build app bin
RUN CGO_ENABLED=0 go build -o webserver .

# image
FROM alpine:latest

# workdir
WORKDIR /app

# copy binary
COPY --from=builder /app/webserver .

# copy static contents 
COPY src/ ./src
RUN chmod +x /app/webserver
EXPOSE 8080

CMD ["./webserver"]
