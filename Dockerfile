FROM archlinux@sha256:42a33e798a4962982756560a6bd4b630e5394bca4d82ba199df0fc45ad3af7bf

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
