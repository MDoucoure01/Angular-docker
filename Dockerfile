# Étape 1: Utiliser une image Node pour builder l'application Angular
FROM node:18.17.1 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier package.json et package-lock.json dans le répertoire de travail
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier tout le code de l'application dans le répertoire de travail
COPY . .

# Builder l'application Angular pour la production
RUN npm run build --prod

# Étape 2: Utiliser une image Nginx pour servir l'application
FROM nginx:alpine

# Copier les fichiers de build Angular dans le répertoire de Nginx
COPY --from=build /app/dist/angular-docker /usr/share/nginx/html

# Exposer le port 8080
EXPOSE 8080

# Commande pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
