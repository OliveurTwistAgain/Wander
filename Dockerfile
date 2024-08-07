FROM ghost:5-alpine as cloudinary
RUN apk add g++ make python3
RUN su-exec node yarn add ghost-storage-cloudinary

FROM ghost:5-alpine
COPY --chown=node:node --from=cloudinary $GHOST_INSTALL/node_modules $GHOST_INSTALL/node_modules
COPY --chown=node:node --from=cloudinary $GHOST_INSTALL/node_modules/ghost-storage-cloudinary $GHOST_INSTALL/content/adapters/storage/ghost-storage-cloudinary

# Utiliser les variables d'environnement pour configurer Ghost
ENV url=${URL}
ENV database__client=postgres
ENV database__connection__host=${DATABASE_HOST}
ENV database__connection__user=${DATABASE_USER}
ENV database__connection__password=${DATABASE_PASSWORD}
ENV database__connection__database=${DATABASE_NAME}
ENV database__connection__port=${DATABASE_PORT}
ENV mail__transport=SMTP
ENV mail__options__service=Mailgun
ENV mail__options__auth__user=${MAIL__OPTIONS__AUTH__USER}
ENV mail__options__auth__pass=${MAIL__OPTIONS__AUTH__PASS}

# Afficher les variables d'environnement pour le débogage
RUN echo "URL: $url"
RUN echo "DATABASE_HOST: $database__connection__host"
RUN echo "DATABASE_USER: $database__connection__user"
RUN echo "DATABASE_PASSWORD: $database__connection__password"
RUN echo "DATABASE_NAME: $database__connection__database"
RUN echo "DATABASE_PORT: $database__connection__port"
RUN echo "MAIL__TRANSPORT: $mail__transport"
RUN echo "MAIL__OPTIONS__SERVICE: $mail__options__service"
RUN echo "MAIL__OPTIONS__AUTH__USER: $mail__options__auth__user"
RUN echo "MAIL__OPTIONS__AUTH__PASS: $mail__options__auth__pass"

# Configurer et lancer Ghost avec le ghost-storage-cloudinary et les options mailgun
RUN set -ex; \
    su-exec node ghost config storage.active ghost-storage-cloudinary; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.use_filename true; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.unique_filename false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.overwrite false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.quality auto; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.cdn_subdomain true; \
    su-exec node ghost config url ${url}; \
    su-exec node ghost config mail.transport ${MAIL__TRANSPORT}; \
    su-exec node ghost config mail.options.service ${MAIL__OPTIONS__SERVICE}; \
    su-exec node ghost config mail.options.auth.user ${MAIL__OPTIONS__AUTH__USER}; \
    su-exec node ghost config mail.options.auth.pass ${MAIL__OPTIONS__AUTH__PASS};

EXPOSE 2368
CMD ["node", "current/index.js"]
