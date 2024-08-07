# Utiliser l'image officielle Ghost comme image de base
FROM ghost:latest

# Installer l'adaptateur Cloudinary pour Ghost
RUN npm install ghost-storage-cloudinary

# Copier le fichier de configuration Ghost personnalisé
COPY config.production.json /var/lib/ghost/config.production.json

# Exposer le port par défaut utilisé par Ghost
EXPOSE 2368

# Commande pour démarrer Ghost
CMD ["npm", "start"]
