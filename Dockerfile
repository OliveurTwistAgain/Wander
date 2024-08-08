# Utiliser l'image officielle Ghost comme image de base
FROM ghost:latest

# Installer l'adaptateur Cloudinary pour Ghost
RUN npm install ghost-storage-cloudinary

# Copier le fichier de configuration Ghost personnalisé
COPY config.production.json /var/lib/ghost/config.production.json

# Exposer le port par défaut utilisé par Ghost
EXPOSE 2368

# Créer un utilisateur non-root et changer le propriétaire des fichiers
RUN groupadd -r ghost && useradd -r -g ghost ghost && \
    chown -R ghost:ghost /var/lib/ghost

# Utiliser l'utilisateur non-root pour exécuter Ghost
USER ghost

# Définir les variables d'environnement par défaut
ENV NODE_ENV=production
ENV DATABASE_HOST=mysql-wander.alwaysdata.net
ENV DATABASE_USER=wander
ENV DATABASE_PASSWORD=rangiroa
ENV DATABASE_NAME=wander_db
ENV DATABASE_PORT=3306
ENV CLOUDINARY_URL=cloudinary://988738855795855:x9AxQ6Eid6CNxBzvvbEBLyyMuv8@ducxgwmbk

# Commande pour démarrer Ghost
CMD ["ghost", "run"]
