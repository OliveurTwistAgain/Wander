#!/bin/bash
# Remplace les variables dans le fichier de configuration avec les valeurs des variables d'environnement
envsubst < /var/lib/ghost/config.production.json > /var/lib/ghost/config.production.json.tmp && mv /var/lib/ghost/config.production.json.tmp /var/lib/ghost/config.production.json

# Démarrer Ghost
ghost run
