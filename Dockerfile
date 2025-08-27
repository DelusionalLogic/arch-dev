FROM archlinux@sha256:97c56e9c792dc50df96c77187255a752f479698c9beb4aa9caeb9fe4639a7590

ENV TZ Europe/Copenhagen

COPY mirrorlist /etc/pacman.d/mirrorlist

RUN pacman-key --init && \
    pacman --disable-download-timeout -Syu --noconfirm && \
    useradd --shell /bin/zsh --create-home delusional && \
    usermod -aG wheel delusional && \
    pacman -S --noconfirm base-devel cmake sudo openssh && \
    echo delusional ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/delusional && \
    chmod 0440 /etc/sudoers.d/delusional

RUN pacman -S --noconfirm \
    zsh less git git-lfs sudo jdk21-openjdk maven github-cli ripgrep neovim openconnect \
    docker stow python fzf jq && \
    pacman -Scc --noconfirm

USER delusional:delusional
WORKDIR /home/delusional

COPY --chown=delusional:delusional settings.xml /home/delusional/.m2/
