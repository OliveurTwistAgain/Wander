# Utiliser l'image Ghost officielle
FROM ghost:5-alpine

# Copier les fichiers de configuration et adapter le stockage Cloudinary
COPY --chown=node:node $GHOST_INSTALL/node_modules $GHOST_INSTALL/node_modules
COPY --chown=node:node $GHOST_INSTALL/node_modules/ghost-storage-cloudinary $GHOST_INSTALL/content/adapters/storage/ghost-storage-cloudinary

# Utiliser les variables d'environnement pour configurer Ghost
ENV url=${URL}
ENV database__client=mysql
ENV database__connection__host=${database__connection__host}
ENV database__connection__user=${database__connection__user}
ENV database__connection__password=${database__connection__password}
ENV database__connection__database=${database__connection__database}
ENV database__connection__port=${database__connection__port}
ENV mail__transport=SMTP
ENV mail__options__service=Mailgun
ENV mail__options__auth__user=${mail__options__auth__user}
ENV mail__options__auth__pass=${mail__options__auth__pass}
ENV CLOUDINARY_URL=${CLOUDINARY_URL}

# Afficher les variables d'environnement pour débogage
RUN echo "URL: $url"
RUN echo "DATABASE_HOST: $database__connection__host"
RUN echo "DATABASE_USER: $database__connection__user"
RUN echo "DATABASE_PASSWORD: $database__connection__password"
RUN echo "DATABASE_NAME: $database__connection__database"
RUN echo "DATABASE_PORT: $database__connection__port"
RUN echo "MAIL__OPTIONS__AUTH__USER: $mail__options__auth__user"
RUN echo "MAIL__OPTIONS__AUTH__PASS: $mail__options__auth__pass"
RUN echo "CLOUDINARY_URL: $CLOUDINARY_URL"

# Configurer Ghost avec le stockage Cloudinary et les options Mailgun
RUN set -ex; \
    su-exec node ghost config storage.active ghost-storage-cloudinary; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.use_filename true; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.unique_filename false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.overwrite false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.quality auto; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.cdn_subdomain true; \
    su-exec node ghost config url ${url}; \
    su-exec node ghost config mail.transport ${mail__transport}; \
    su-exec node ghost config mail.options.service ${mail__options__service}; \
    su-exec node ghost config mail.options.auth.user ${mail__options__auth__user}; \
    su-exec node ghost config mail.options.auth.pass ${mail__options__auth__pass};

# Exposer le port sur lequel Ghost sera accessible
EXPOSE 2368

# Démarrer Ghost
CMD ["node", "current/index.js"]
