Déployer Ghost sur Koyeb depuis un Dockerfile avec variables API d'environnement : 

Requis : 

ouvrir un compte koyeb

Ouvrir un compte cloudinary (images, médias)

ouvrir un compte mailgun (emails)

ouvrir un compte supabase (db postgres)

création d'un Dockerfile pour installer et lancer Ghost


Nom des variables API utilisées : 

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
