ARG NODE_VERSION=24.14.0-alpine
 
FROM node:${NODE_VERSION} AS builder
 
# Set working directory inside the container
WORKDIR /app
 
# Copy package files
COPY package*.json ./
 
# Install dependencies
RUN npm install
 
# Copy rest of the source code
COPY . .
 
 
RUN npm run build

FROM nginx:alpine

COPY --from=builder /app/build /usr/share/nginx/html

# Expose Vite dev server port
EXPOSE 80
 
# Run Vite in dev mode, accessible outside the container
CMD ["nginx", "-g", "daemon off;"]