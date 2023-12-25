FROM debian:latest
RUN apt update && apt install -y curl gettext-base gpg && \
    apt clean && \
    curl repo.data.kit.edu/repo-data-kit-edu-key.gpg \
    | apt-key add - && \
    echo "deb https://repo.data.kit.edu/debian/stable ./" \
    > /etc/apt/sources.list.d/kit.list && \
    apt update && apt install -y oidc-agent && \
    apt clean && \
    curl -L https://github.com/DODAS-TS/rclone/releases/download/v1.58.3/rclone_linux -o /usr/local/bin/rclone && \
    chmod +x /usr/local/bin/rclone && \
    adduser --disabled-password --gecos '' docker
USER docker    
