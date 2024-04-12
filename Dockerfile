FROM  golang:1.21-alpine AS build

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN go build -o build/fizzbuzz

FROM scratch

WORKDIR /app

COPY --from=build /app/templates templates
COPY --from=build /app/build/fizzbuzz fizzbuzz

CMD ["./fizzbuzz", "serve"]