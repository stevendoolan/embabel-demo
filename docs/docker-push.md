[← Previous: Docker](docker.md) | [Back to Index](../README.md) | [Next: Docker Compose →](docker-compose.md)

---

# Pushing to Docker Hub

The `docker-push.sh` script builds and pushes the Docker image to Docker Hub with both a date-time versioned tag and `latest`.

## Using the script

Log in to Docker Hub first (you only need to do this once):
```bash
docker login
```

Set the `DOCKER_USER` environment variable to your Docker Hub username:
```bash
export DOCKER_USER=stevendoolan
```

To make this permanent, add the above line to your `~/.zshrc` file.

Then run the script:
```bash
./docker-push.sh
```

This will:
1. Build the Docker image
2. Tag it with a date-time version (e.g. `stevendoolan/embabel-demo:20260404-153042`)
3. Tag it as `latest` (e.g. `stevendoolan/embabel-demo:latest`)
4. Push both tags to Docker Hub

## Manual fallback commands

If you prefer to run the commands manually (or don't have zsh), here's what `docker-push.sh` does:

```bash
# Set your Docker Hub username
export DOCKER_USER=stevendoolan

# Generate a date-time tag
TAG=$(date +%Y%m%d-%H%M%S)

# Build the image with both tags
docker build -t ${DOCKER_USER}/embabel-demo:${TAG} -t ${DOCKER_USER}/embabel-demo:latest .

# Log in to Docker Hub (if not already logged in)
docker login

# Push both tags
docker push ${DOCKER_USER}/embabel-demo:${TAG}
docker push ${DOCKER_USER}/embabel-demo:latest
```

---

[← Previous: Docker](docker.md) | [Back to Index](../README.md) | [Next: Docker Compose →](docker-compose.md)
