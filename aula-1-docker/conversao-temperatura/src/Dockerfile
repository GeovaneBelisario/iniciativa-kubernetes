FROM node:14.17.5
WORKDIR /app
COPY package*.json ./
RUN npm install
# esta usando as camadas de construção  da imagem e do cache pra ganhar performance, so vai executar o npm install se mudar o package.json
# se colocar primeiro para copiar td, qualquer arquivo q for modificado sera executado o npm install
COPY . .
EXPOSE 8080
CMD [ "node", "server.js" ]