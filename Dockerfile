# Etapa 1: Build de la app
FROM node:20 AS build
WORKDIR /app
COPY . .
RUN npm install \
	&& chmod +x node_modules/.bin/* \
	&& npm run build

# Etapa 2: Servir la app estática con nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
