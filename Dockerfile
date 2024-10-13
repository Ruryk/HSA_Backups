FROM postgres:latest

# Environment variables for PostgreSQL
ENV POSTGRES_DB=db_pet_project
ENV POSTGRES_USER=user
ENV POSTGRES_PASSWORD=password

# Install rsync to support reverse delta backup
RUN apt-get update && apt-get install -y rsync

# Create a volume for storing backups
VOLUME ["/var/lib/postgresql/data", "/backups"]

# Set the working directory
WORKDIR /usr/local/bin

# Copy initialization scripts
COPY ./init /docker-entrypoint-initdb.d/

# Copy the backup scripts
COPY ./scripts /usr/local/bin/

# Give execute permissions to the scripts
RUN chmod +x /usr/local/bin/*.sh

# Expose the default PostgreSQL port
EXPOSE 5432
