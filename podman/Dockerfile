FROM golang:1.13.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    automake \
    libsystemd-dev \
    libgpgme-dev \
    libseccomp-dev \
    && apt-get clean

COPY build-podman.sh /usr/local/bin
ENTRYPOINT [ "build-podman.sh" ]
