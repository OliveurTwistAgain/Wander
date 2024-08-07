# Déployer Ghost sur Koyeb depuis un Dockerfile avec Variables API d'Environnement

Ce dépôt contient un Dockerfile configuré pour déployer [Ghost](https://ghost.org/) sur [Koyeb](https://www.koyeb.com/). Ghost est une plateforme de blogging open-source. Ce guide explique comment configurer et déployer Ghost avec les variables API d'environnement nécessaires pour l'intégration avec Cloudinary, Mailgun, Supabase, et Koyeb.

## Requis

Avant de commencer, vous devez configurer les services suivants :

1. **Koyeb** : Créez un compte sur [Koyeb](https://www.koyeb.com/) pour déployer votre application.
2. **Cloudinary** : Créez un compte sur [Cloudinary](https://cloudinary.com/) pour gérer les images et les médias.
3. **Mailgun** : Créez un compte sur [Mailgun](https://www.mailgun.com/) pour la gestion des emails.
4. **Supabase** : Créez un compte sur [Supabase](https://supabase.io/) pour la base de données PostgreSQL.

## Création d'un Dockerfile

Le Dockerfile fourni dans ce dépôt est configuré pour installer et lancer Ghost avec les extensions nécessaires pour Cloudinary. Voici comment configurer les variables d'environnement nécessaires :

### Nom des Variables API Utilisées

```bash
CLOUDINARY_URL=cloudinary://xxx
DATABASE_CLIENT=postgres
DATABASE_HOST=xxxx.supabase.com
DATABASE_NAME=xxx
DATABASE_PASSWORD=xxx
DATABASE_PORT=6543
DATABASE_USER=postgres.xxx
MAIL__OPTIONS__AUTH__PASS=xxx
MAIL__OPTIONS__AUTH__USER=postmaster@xxx.mailgun.org
MAIL__OPTIONS__SERVICE=Mailgun
MAIL__TRANSPORT=SMTP
URL=https://xxx-xxx-xxx.koyeb.app/
