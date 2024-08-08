# Utiliser l'image officielle Ghost comme image de base
FROM ghost:latest

# Installer l'adaptateur Cloudinary pour Ghost
RUN npm install ghost-storage-cloudinary

# Copier le fichier de configuration Ghost personnalisé
COPY config.production.json /var/lib/ghost/config.production.json

# Copier le script d’entrée
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Exposer le port par défaut utilisé par Ghost
EXPOSE 2368

# Créer un utilisateur non-root et changer le propriétaire des fichiers
RUN groupadd -r ghost && useradd -r -g ghost ghost && \
    chown -R ghost:ghost /var/lib/ghost

# Utiliser l'utilisateur non-root pour exécuter Ghost
USER ghost

# Définir le script d'entrée
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Commande pour démarrer Ghost
CMD ["ghost", "run"]
