# Docker Setup for Laravel Project

This guide covers setting up your Laravel project using Docker for local development.

Follow these steps:

1. **Copy Files to Laravel Root Folder:**

    Copy all the Docker-related files to your Laravel project's root folder.

2. **Create or Update .env File:**
    ```shell
    cp .env.docker .env
    ```

3. **Update Database Credentials:**

    Open the `.env` file and update the database credentials to match your local environment.

4. **Build the docker**
    ```shell
    docker compose build
    ```

4. **Run the docker**
    ```shell
    docker compose up 
    ```
That's it! Your Laravel project is now ready to run with Docker.
