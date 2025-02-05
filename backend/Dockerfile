# FROM node:22-alpine
# WORKDIR /app
# COPY . .
# COPY .env.docker .env
# RUN npm install
# RUN npm run test
# EXPOSE 8080
# CMD [ "npm" , "start" ]

# Stage 1: Build Stage
FROM node:21 AS backend-builder

# Set up the working directory
WORKDIR /app

# Copy package.json and package-lock.json first to leverage Docker caching
COPY package*.json ./

# Install dependencies, including TypeScript
RUN npm install

# Copy the rest of the code
COPY . .

# Compile TypeScript to the 'dist' directory
RUN npx tsc  # This will compile TypeScript files

# Stage 2: Runtime Stage
FROM node:21-slim

# Set up the working directory
WORKDIR /app

# Copy the compiled JavaScript files from the build stage
COPY --from=backend-builder /app/dist ./dist

# Copy environment variables
COPY .env.docker .env

# Expose the application port
EXPOSE 8080

# Start the application from the compiled JavaScript
CMD ["node", "dist/server.js"]
