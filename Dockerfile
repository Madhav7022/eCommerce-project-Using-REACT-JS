#########################################
# eCommerce Project — Dockerfile
# Built & Automated by: Madhav7022
#########################################

# ---------- Stage 1: Build React App ----------
FROM node:18-alpine AS build

WORKDIR /app

# Copy package files first (for caching)
COPY package*.json ./
RUN npm install

# Copy remaining project files
COPY . .

# Build production app
RUN npm run build


# ---------- Stage 2: Serve with Nginx ----------
FROM nginx:alpine

# Remove default nginx files
RUN rm -rf /usr/share/nginx/html/*

# Copy built app from build stage
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
