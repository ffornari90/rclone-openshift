FROM bitnami/rclone
USER root
RUN apt update && \
    apt install -y curl gpg && \
    apt clean && \
    curl repo.data.kit.edu/repo-data-kit-edu-key.gpg \
    | apt-key add - && \
    echo "deb https://repo.data.kit.edu/debian/stable ./" \
    > /etc/apt/sources.list.d/kit.list && \
    apt update && apt install -y oidc-agent && \
    apt clean && \
    adduser --disabled-password --gecos '' docker
USER docker
