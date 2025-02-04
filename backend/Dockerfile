# FROM node:22-alpine
# WORKDIR /app
# COPY . .
# COPY .env.docker .env
# RUN npm install
# RUN npm run test
# EXPOSE 8080
# CMD [ "npm" , "start" ]

# Stage 1
FROM node:21 AS backend-builder

# setup the working dir
WORKDIR /app

# code
COPY . .

# packages install
RUN npm install

# tests
# RUN npm run test

# Stage 2
FROM node:21-slim

# setup the working dir
WORKDIR /app

# copy the above stage as compressed
COPY --from=backend-builder /app .

COPY .env.docker .env

# Port
EXPOSE 8080

# App
CMD ["npm", "start"]