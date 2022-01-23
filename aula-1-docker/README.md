# Aula 1 - Docker

## Porque a sua equipe deve adotar containers e os benefícios no uso da tecnologia?

O uso de conteiners diminui consideravelmente o custo e tempo de gestão de infraestrutura (máquinas virtuais/Sistema operacional) pois dentro de 1 container concentramos tudo o que precisamos para executar determinada aplicação, sem se preocupar se os componentes dentro do container vão afetar demais componentes da máquina (isso não vai acontecer pois tudo está restrito dentro do container). Com isso temos uma simplicidade na gestão dos recursos, além da redução de custos/recursos.
A inicialização do container é muito superior a inicialização de uma máquina virtual, gerando performance para o time.

## Porque máquinas virtuais e containers são diferentes e quais são as vantagens da containerização?

Máquina virtual: inicialização lenta, precisa alocar recursos computacionais de forma antecipada, precisa se preocupar com sistema operacional e todas as features executando nesse sistema operacional. Vantagens da containerização: containers executando uma aplicação, server web, banco de dados pode ser iniciado rapidamente, tudo o que precisa para executar o container está dentro da imagem e assim não afeta demais aplicações em execução.

Containers cria um isolamento garantindo que ele funcione em qualquer lugar, já que tudo que ele precisa para funcionar está dentro da imagem. Muito mais rápido subir containers ao invés de instalar servers, bancos de dados, etc

## Conteudos

- [Iniciar a api conversao-temperatura](#iniciar-a-api-conversao-temperatura)
- [Boas práticas na construção de imagens Docker](#boas-práticas-na-construção-de-imagens-docker)
- [Docker registry (Docker Hub)](#docker-registry-docker-hub)
- [Comandos](#comandos)
- [Troubleshooting](#troubleshooting)
- [Criar imagem](#criar-imagem)

## Iniciar a api conversao-temperatura

1. vá ate a pasta conversao-temperatura, onde estar o Dockerfile e rode:
   1. `docker image build -t geovanebelisario/conversao-temperatura:v1 .`
   1. `docker container run -d -p 8080:8080 conversao-temperatura`
1. abra o navegador cole a url `localhost:8080`

## Boas práticas na construção de imagens Docker

1. nameando imagem docker
   1. namespace/repositorio:tag
   1. geovanebelisario/api-conversao:v1  
1. de preferencia a imagens oficiais
1. sempre especifique a tag nas imagens: `FROM node:14.17.5` ao inves de `FROM node`. Isso porque sempre tera certeza de que o codigo ira funcionar, pois esta usando sempre a mesma versao.
1. use um processo por container, ao inves de rodar node, mariaDB e rabbitMQ tudo no mesmo container.
1. aproveite as camadas da imagem: aumente a performance da construção  da imagem, usando o cache de camadas de imagem.
1. use o .dockerignore: pra colocar pastas como node_modules, pelo mesmo motivo como o .gitignore é usado.
1. use COPY ao inves de ADD: COPY só copia um arquivo local pra imagem, ADD funciona tbm pra arquivos compactados, arquivos em um servidor na internet e jogando pra imagem. na duvida use o COPY.
1. ENTRYPOINT vs CMD: ENTRYPOINT é usado quando a inicializacao do container é imutavel, quando não muda o start do container. o CMD da a possibilidade de sobreescrever a inicializacao. pasta "./entry"
1. usar agumentos na construção  de imagens: pasta "./imagem-arg"
1. multistage build: usada em linguagem compilada ou JIT (compilada e interpretada como php 8, java, c#). usar imagem de compilacao para ser o intermediario e imagem final para executar a aplicação. pasta "./go-app

## Docker registry (Docker Hub)

- `docker login`
- `docker push geovanebelisario/conversao-temperatura:v1`: envia a imagem pro dockerhub
- `docker tag geovanebelisario/conversao-temperatura:v1 geovanebelisario/conversao-temperatura:latest`: cria uma outra tag. É uma boa pratica subir uma imagem como latest.
- `docker push geovanebelisario/conversao-temperatura:latest`

## Comandos

- `docker container ls -a`:
- `docker container rm <container-id-ou-name>`
- `docker container rm e8e`: os 3 primeiros digitos do container id

- `docker container run <imagem>`
- `docker container run --name <nome> <imagem>`
- `docker container run --name meucontainer hello-world`
- `docker container run --name meucontainer --rm hello-world`: --rm remove o container quando ele é fechado
- `docker container run -it ubuntu /bin/bash`: -t habilita tty, -i modo iterativo pra usar o terminal
- `docker container run -d nginx`: executa em modo deamon, em segundo plano, sem prender o terminal
- `docker container run -d -p <porta-local>:<porta-container> <imagem>`: redireciona a porta local para a porta do container
- `docker container run -d -p 8080:80 nginx`
- `docker container rm -f hello-world`: quando esta em execucao, tem q usar a remocao forçada
- `docker container run -d -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=mongouser -e MONGO_INITDB_ROOT_PASSWORD=mongopwd mongo`: -e passa as variaveis de ambiente

- `docker image ls`: lista as imagens
- `docker image prune`: elimina as images que não tem mais referencia
- `docker image rm`: remove a imagem
- `docker image inspect`: dados da imagem
- `docker image history`: dados de criacao da imagem

## Troubleshooting

- `docker container inspect <id-ou-name>`: informacoes do container (estado do container, elementos de rede, volumes)
- `docker container exec -it <id-ou-name>`: abre o terminal do container que ja esta em execucao
- `docker stop <id-ou-name>`
- `docker container start <id-ou-name>`
- `docker container logs <id-ou-name>`: consegue ver o stdout do container
- `docker container -n 5 <id-ou-name>`: mostra as ultimas 5 linhas do log
- `docker container -f <id-ou-name>`: -f follow, acompanha em tempo real o log
- `docker container -t`: mostra as horas de cada log

## Criar imagem

### Má prática -> usar o commit

_Commit é trabalhoso e não é versionavel__

docker commit `<container-id> <nome-desejado>`

### Boa pŕatica -> usar Dockerfile

./Dockerfile

```Dockerfile
# a partir de qual imagem va ser criada a atual
FROM ubuntu 

# executa a instrucao
# o ideal é usar os comandos concatenado com '&&' em caso de atualizacao de pacotes ou repositorios, pois caso tenha feito cache do 'apt-get update', alguns pacotes podem ficar desatualizados usando repositorios antigos
RUN apt-get update && apt-get install curl --yes && apt-get install vim --yes
```

`docker image build -t docker-curl-file .`

### Comandos do dockerfile

![Comandos do dockerfile](./img-1.png)
