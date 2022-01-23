# a partir de qual imagem va ser criada a atual
FROM ubuntu 

# executa a instrucao
# o ideal é usar os comandos concatenado com '&&' em caso de atualizacao de pacotes ou repositorios, pois caso tenha feito cache do 'apt-get update', alguns pacotes podem ficar desatualizados usando repositorios antigos
RUN apt-get update && apt-get install curl --yes && apt-get install vim --yes