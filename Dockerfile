FROM node:10

ARG build_script=build-local

RUN echo "BUILD SCRIPT = ${build_script}"

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./
RUN npm install

COPY . .

RUN npm run ${build_script}

WORKDIR /usr/src/app/deployment
RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
WORKDIR /usr/src/app/deployment/www/

RUN cp -r /usr/src/app/dist/SBH-Webchat-UI/* .

WORKDIR /usr/src/app/deployment

RUN npm install

EXPOSE 3440

CMD [ "node", "server.js" ]
