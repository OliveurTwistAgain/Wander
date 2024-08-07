# Utiliser l'image officielle de Ghost
FROM ghost:5-alpine

# Installer les dépendances nécessaires pour Ghost
RUN apk add --no-cache g++ make python3

# Configurer les variables d'environnement pour Ghost avec db MySQL sur Alwaysdata
ENV url=${URL}
ENV database__client=mysql
ENV database__connection__host=${DATABASE_HOST}
ENV database__connection__user=${DATABASE_USER}
ENV database__connection__password=${DATABASE_PASSWORD}
ENV database__connection__name=${DATABASE_NAME}
ENV database__connection__port=${DATABASE_PORT}
ENV mail__transport=SMTP
ENV mail__options__service=Mailgun
ENV mail__options__auth__user=${MAIL__OPTIONS__AUTH__USER}
ENV mail__options__auth__pass=${MAIL__OPTIONS__AUTH__PASS}
ENV CLOUDINARY_URL=${CLOUDINARY_URL}

# Configurer Ghost sur Koyeb avec les variables d'environnement
RUN set -ex; \
    su-exec node ghost config url ${url}; \
    su-exec node ghost config database.client ${database__client}; \
    su-exec node ghost config database.connection.host ${database__connection__host}; \
    su-exec node ghost config database.connection.user ${database__connection__user}; \
    su-exec node ghost config database.connection.password ${database__connection__password}; \
    su-exec node ghost config database.connection.database ${database__connection__database}; \
    su-exec node ghost config database.connection.port ${database__connection__port}; \
    su-exec node ghost config mail.transport ${mail__transport}; \
    su-exec node ghost config mail.options.service ${mail__options__service}; \
    su-exec node ghost config mail.options.auth.user ${mail__options__auth__user}; \
    su-exec node ghost config mail.options.auth.pass ${mail__options__auth__pass}; \
    su-exec node ghost config storage.active ghost-storage-cloudinary; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.use_filename true; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.unique_filename false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.overwrite false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.quality auto; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.cdn_subdomain true;

# Exposer le port sur lequel Ghost sera accessible
EXPOSE 2368

# Démarrer Ghost
CMD ["node", "current/index.js"]
