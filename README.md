# Docker MatterBridge container

## To build it
```bash
docker build -t ryarnyah/docker-matterbridge:latest .
```

## To run it
```bash
cp matterbridge.toml.sample matterbridge.toml
docker run -d -v $(pwd):/etc/matterbridge:ro --drop-cap=ALL ryarnyah/docker-matterbridge:latest
```
