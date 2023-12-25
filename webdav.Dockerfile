FROM bitnami/rclone
USER root
RUN DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y curl gpg wget fuse3 && \
    DEBIAN_FRONTEND=noninteractive apt clean && \
    curl repo.data.kit.edu/repo-data-kit-edu-key.gpg \
    | apt-key add - && \
    echo "deb https://repo.data.kit.edu/debian/stable ./" \
    > /etc/apt/sources.list.d/kit.list && \
    curl "https://crt.sh/?d=2475254782" -o /usr/local/share/ca-certificates/geant-ov-rsa-ca.crt && \
    wget -q -O - "https://dist.eugridpma.info/distribution/igtf/current/GPG-KEY-EUGridPMA-RPM-3" | apt-key add - && \
    echo "deb http://repository.egi.eu/sw/production/cas/1/current egi-igtf core" > /etc/apt/sources.list.d/ca-repo.list && \
    DEBIAN_FRONTEND=noninteractive apt update && \
    DEBIAN_FRONTEND=noninteractive apt install -y ca-policy-egi-core oidc-agent && \
    DEBIAN_FRONTEND=noninteractive apt clean && \
    for f in `find /etc/grid-security/certificates -type f -name '*.pem'`; \
    do filename="${f##*/}"; cp $f /usr/local/share/ca-certificates/"${filename%.*}.crt"; done && \
    update-ca-certificates && \
    adduser --disabled-password --gecos '' docker
USER docker
