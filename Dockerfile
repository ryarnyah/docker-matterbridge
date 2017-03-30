FROM debian:8

LABEL MAINTAINER "Ryar Nyah <ryarnyah@gmail.com>"

ENV GOPATH /go

RUN echo "deb http://deb.debian.org/debian sid main" > /etc/apt/sources.list.d/sid.list && \
    apt-get update && \
    apt-get install -y \
            git \
            gcc \
            golang \
            ca-certificates \
            libc-dev && \
    mkdir -p /go/src/github.com/42wim && \
    cd /go/src/github.com/42wim/ && git clone https://github.com/42wim/matterbridge.git && \
    cd matterbridge && go get && \
    go build -x -ldflags "-X main.githash=$(git log --pretty=format:'%h' -n 1)" -o /bin/matterbridge && \
    rm -fr /go /src && \
    apt-get remove --purge -y \
             git \
             gcc \
             golang \
             libc-dev && \
    apt-get autoremove --purge -y && \
    apt-get autoclean -y && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

VOLUME [ "/etc/matterbridge" ]
CMD [ "/bin/matterbridge", "-conf", "/etc/matterbridge/matterbridge.toml" ]
