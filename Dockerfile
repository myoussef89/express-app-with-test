FROM node:14-alpine

WORKDIR /src
COPY . /src
COPY package*.json /src
RUN npm install -g nodemon && npm install
EXPOSE 3000
CMD ["nodemon", "/bin/www"]
