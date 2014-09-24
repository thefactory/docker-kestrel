
Runs a [Kestrel](https://github.com/twitter/kestrel) server.

Available on the Docker Index as [thefactory/kestrel](https://registry.hub.docker.com/u/thefactory/kestrel/):

    docker pull thefactory/kestrel

### Versions
* Kestrel 2.4.2

### Usage
Start the container with a volume mounted on `datafor persistence:

    docker run -p 22133:22133 -v /local_path:/data thefactory/kestrel:latest
