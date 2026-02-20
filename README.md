# Getting Started Todo App (Enhanced)

> **Based on the original [getting-started-todo-app](https://github.com/docker/getting-started-todo-app) by Docker.**

This project provides a sample todo list application. It demonstrates all of the current Docker best practices, ranging from the Compose file, to the Dockerfile, to CI (using GitHub Actions), and running tests. It's intended to be well-documented to ensure anyone can come in and easily learn.

## Modifications in this Version

This repository contains enhancements and configuration fixes to improve stability and local development experience:

*   **Port Re-mapping**: The application proxy has been moved to port **81** (instead of 80) to prevent conflicts with system services.
*   **Traefik Configuration**: Updated with explicit entrypoints (`web` on port 80 internal) and debug logging enabled for better troubleshooting.
*   **Vite Configuration**: Updated `client/vite.config.js` to ensure the dev server binds to `0.0.0.0`, fixing connectivity issues within the container network.

## Application architecture

![image](https://github.com/docker/getting-started-todo-app/assets/313480/c128b8e4-366f-4b6f-ad73-08e6652b7c4d)


This sample application is a simple React frontend that receives data from a Node.js backend. 

When the application is packaged and shipped, the frontend is compiled into static HTML, CSS, and JS and then bundled with the backend where it is then served as static assets. So no... there is no server-side rendering going on with this sample app.

During development, since the backend and frontend need different dev tools, they are split into two separate services. This allows [Vite](https://vitejs.dev/) to manage the React app while [nodemon](https://nodemon.io/) works with the backend. With containers, it's easy to separate the development needs!

## Development

To spin up the project, simply install Docker Desktop and then run the following commands:

```bash
# Clone this repository
docker compose up --watch
```

You'll see several container images get downloaded from Docker Hub and, after a moment, the application will be up and running! No need to install or configure anything on your machine!

### Accessing the App

*   **Frontend**: [http://localhost:81](http://localhost:81)
*   **Backend API**: [http://localhost:81/api/items](http://localhost:81/api/items)
*   **Database Admin (phpMyAdmin)**: [http://db.localhost:81](http://db.localhost:81)

Any changes made to either the backend or frontend should be seen immediately without needing to rebuild or restart the containers.

### Tearing it down

When you're done, simply remove the containers by running the following command:

```bash
docker compose down
```

## Building the Image (Production)

This project supports both traditional Docker builds and advanced builds using Docker Buildx and Bake.

### Option 1: Modern Build (Recommended)
Using **Docker Buildx Bake** allows for parallel builds, advanced caching, and multi-platform support (when configured).

1.  **Ensure Buildx is enabled**:
    ```bash
    docker buildx version
    ```
2.  **Build using Bake**:
    ```bash
    # Build for the current architecture (dev/local use)
    docker buildx bake app
    
    # Print the build configuration (dry run)
    docker buildx bake --print
    ```

### Option 2: Traditional Build
You can still build the image using the standard Docker command.

```bash
docker build -t getting-started-todo-app:latest .
```

**Note**: The Dockerfile uses cache mounts (`--mount=type=cache`). These are supported by the default Docker builder in modern versions (using BuildKit), so no special flags are usually required. If you encounter issues, enable BuildKit: `DOCKER_BUILDKIT=1 docker build ...`.


## License

**Apache License 2.0**

*   Original work Copyright 2024 Docker, Inc.
*   Modifications Copyright 2026 [Manjunatha Shetty]

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at [http://www.apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

See the [LICENSE](LICENSE) file for details.
