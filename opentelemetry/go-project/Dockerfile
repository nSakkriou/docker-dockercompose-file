# Utiliser l'image officielle de Go comme image de base
FROM golang:1.16

# Créer et définir le répertoire de travail
WORKDIR /app

# Copier le go.mod et le go.sum pour le caching des dépendances
COPY go.mod go.sum ./

# Télécharger les dépendances
RUN go mod download

# Copier le code source dans le conteneur
COPY . .

# Construire l'application
RUN go build -o main .

# Exposer le port sur lequel l'application écoutera
EXPOSE 8080

# Démarrer l'application
CMD ["./main"]
