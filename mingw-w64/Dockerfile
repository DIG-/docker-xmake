ARG ubuntu=latest
ARG xmake=2.8.6
FROM ubuntu:${ubuntu}
ARG xmake
LABEL version=${xmake}
LABEL org.opencontainers.image.authors=contato@dig.dev.br
RUN \
    apt-get update && \
    apt-get install --no-install-recommends -y gcc g++ make cmake curl ca-certificates git ssh-client unzip && \
    apt-get install --no-install-recommends -y g++-mingw-w64-i686-posix g++-mingw-w64-x86-64-posix gcc-mingw-w64-i686-posix gcc-mingw-w64-x86-64-posix msitools && \
    echo "Download xmake v${xmake}" && \
    cd ~ && \
    curl -fsSL https://github.com/xmake-io/xmake/releases/download/v${xmake}/xmake-v${xmake}.gz.run -o xmake.gz.run && \
    chmod +x xmake.gz.run && \
    ./xmake.gz.run --accept && \
    rm xmake.gz.run && \
    apt-get purge -y gcc g++ && \
    apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*
RUN \
    ln -s /root/.local/bin/xmake /usr/bin/xmake && \
    ln -s /root/.local/bin/xrepo /usr/bin/xrepo
ENV XMAKE_ROOT=y