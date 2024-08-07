FROM ghost:5-alpine as cloudinary
RUN apk add g++ make python3
RUN su-exec node yarn add ghost-storage-cloudinary

FROM ghost:5-alpine
COPY --chown=node:node --from=cloudinary $GHOST_INSTALL/node_modules $GHOST_INSTALL/node_modules
COPY --chown=node:node --from=cloudinary $GHOST_INSTALL/node_modules/ghost-storage-cloudinary $GHOST_INSTALL/content/adapters/storage/ghost-storage-cloudinary

# Utiliser les variables d'environnement pour configurer Ghost
ENV database__client=${DATABASE_CLIENT}
ENV database__connection__host=${DATABASE_HOST}
ENV database__connection__user=${DATABASE_USER}
ENV database__connection__password=${DATABASE_PASSWORD}
ENV database__connection__database=${DATABASE_NAME}
ENV database__connection__port=${DATABASE_PORT}
ENV mail__transport=${MAIL__TRANSPORT}
ENV mail__options__service=${MAIL__OPTIONS__SERVICE}
ENV mail__options__auth__user=${MAIL__OPTIONS__AUTH__USER}
ENV mail__options__auth__pass=${MAIL__OPTIONS__AUTH__PASS}
ENV url=${URL}

# Configurer et lancer Ghost avec le ghost-storage-cloudinary et les options mailgun
RUN set -ex; \
    su-exec node ghost config storage.active ghost-storage-cloudinary; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.use_filename true; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.unique_filename false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.upload.overwrite false; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.quality auto; \
    su-exec node ghost config storage.ghost-storage-cloudinary.fetch.cdn_subdomain true; \
    su-exec node ghost config mail.transport ${MAIL__TRANSPORT}; \
    su-exec node ghost config mail.options.service ${MAIL__OPTIONS__SERVICE}; \
    su-exec node ghost config mail.options.auth.user ${MAIL__OPTIONS__AUTH__USER}; \
    su-exec node ghost config mail.options.auth.pass ${MAIL__OPTIONS__AUTH__PASS}; \
    su-exec node ghost config url ${URL};
