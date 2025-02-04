# FROM node:22-alpine
# WORKDIR /app
# COPY . .
# COPY .env.docker .env
# RUN npm cache clean --force && npm install --legacy-peer-deps
# RUN npm run test
# EXPOSE 5173
# CMD [ "npm" , "start" ]

# ------------------- Stage 1: Build Stage ------------------------------
    FROM node:21 AS frontend-builder

    # Set the working directory to /app
    WORKDIR /app
    
    # Copy the package.json and package-lock.json for dependency installation
    COPY package*.json ./
    
    # Install dependencies
    RUN npm cache clean --force && npm install --legacy-peer-deps --ignore-scripts


    
    # Copy the rest of the application code
    COPY . .
    
    # ------------------- Stage 2: Final Stage ------------------------------
    FROM node:21-slim
    
    # Set the working directory to /app
    WORKDIR /app
    
    # Copy built assets and dependencies from frontend-builder stage
    COPY --from=frontend-builder /app .
    
    # Copy the .env.sample file to .env.local
    COPY .env.docker .env.local
    
    # Expose port 5173 for the Node.js application
    EXPOSE 5173
    
    # Define the default command to run the application in development mode
    CMD ["npm", "run", "dev", "--", "--host"]