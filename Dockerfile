FROM archlinux@sha256:c136b06a4f786b84c1cc0d2494fabdf9be8811d15051cd4404deb5c3dc0b2e57

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
