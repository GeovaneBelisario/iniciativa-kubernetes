FROM golang:1.7.3 as build
WORKDIR /app
COPY main.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main

FROM alpine:3.14 as final
WORKDIR /app
# a copia vai ser feita atraves da imagem acima e não da maquina local, entao especifica isso atraves do --from=build
COPY --from=build /app/main .
CMD [ "./main" ]