


https://github.com/user-attachments/assets/26edc1e2-74d3-48e9-bca7-52e664c6aa79


A Rock-Paper-Scissors game simulation using Processing.

## Usage

### Use pre-built binaries

There're two pre-built binaries which you can download [here](https://github.com/Dpbm/Rock-Paper-Scissors/releases/tag/v1).

### Docker

If you prefer you can also use the docker version. For that you may run:

```bash
# from docker hub
docker run -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
           -e DISPLAY=$DISPLAY \
            dpbm32/rock-paper-scissors


# or from ghrc
docker run -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
           -e DISPLAY=$DISPLAY \
           ghcr.io/dpbm/rock-paper-scissors:latest

```

Note that you may have `X` installed in your host machine, and this setup for volume (`-v`) and display environment (`-e`) may change from distro-distro. These commands probably won't work on windows, so check the `X` setup if you wanna try.
