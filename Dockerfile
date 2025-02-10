# Usa Node.js 22 como imagen base
FROM node:22

# Establece el directorio de trabajo
WORKDIR /app

# Copia solo los archivos esenciales para instalar dependencias
COPY package.json package-lock.json ./

# Instala dependencias sin incluir las de desarrollo
RUN npm install --omit=dev

# Copia el resto del código fuente
COPY . .

# Instala node-pre-gyp para evitar errores al reconstruir bcrypt
RUN npm install -g node-pre-gyp

# Reinstala bcrypt para evitar errores en Docker
RUN npm rebuild bcrypt --build-from-source

# Expone los puertos correctos para este servicio
EXPOSE 5007 4007

# Comando para ejecutar el servidor desde src/
CMD ["node", "src/server.js"]
