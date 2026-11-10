FROM golang:1.22-alpine AS builder
WORKDIR /src
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app main.go

FROM gcr.io/distroless/static-debian12
COPY --from=builder /app /app
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["/app"]
