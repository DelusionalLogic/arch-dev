FROM archlinux@sha256:287bf95d97e4f952a94a1f4a83008c6a547405bacc44173bda151231a3c843aa

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
