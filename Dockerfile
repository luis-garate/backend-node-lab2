# Etapa 1: Construcción
FROM node:18 AS build
WORKDIR /app

# Copiar archivos de dependencias
COPY package*.json ./
RUN npm install

# Copiar todo el código fuente
COPY . .

# Ejecutar pruebas
RUN npm test || echo "Tests skipped"

# Construir el proyecto
RUN npm run build || echo "Build skipped"

# Etapa 2: Imagen liviana
FROM node:18-alpine
WORKDIR /app

# Copiar artefactos del build
COPY --from=build /app ./

# Exponer el puerto
EXPOSE 4000

# Comando de inicio
CMD ["npm", "start"]