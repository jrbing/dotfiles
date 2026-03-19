FROM ubuntu:22.04

ARG USERNAME=jrbing
ARG USER_UID=1000
ARG USER_GID=$USER_UID

ENV TZ=America/New_York
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    git \
    bats \
    kcov \
    sudo \
    tzdata \
    parallel \
    build-essential \
    ca-certificates \
    zsh

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -G sudo -s /bin/bash \
    && echo "$USERNAME:$USERNAME" | sudo chpasswd \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER $USERNAME
WORKDIR /home/$USERNAME/.local/share/chezmoi

RUN sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

RUN sudo chown $USERNAME:$USERNAME ~/.local \
    && sudo chown $USERNAME:$USERNAME ~/.local/share

RUN mkdir -p /tmp
