FROM node:20-alpine

WORKDIR /app

# Copy the package files from the app folder into the container
COPY app/package*.json ./

RUN npm install

# Copy everything else from the app folder into the container
COPY app/ .

EXPOSE 3000

CMD ["node", "server.js"]