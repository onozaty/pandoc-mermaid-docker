FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN echo "ubuntu ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/ubuntu \
    && chmod 0440 /etc/sudoers.d/ubuntu

RUN mkdir -p /home/ubuntu/.claude /home/ubuntu/.config/gh && chown -R ubuntu:ubuntu /home/ubuntu/.claude /home/ubuntu/.config/gh
