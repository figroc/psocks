# docker build -t figroc/psocks .
FROM alpine

LABEL maintainer="Figroc Chen<figroc@gmail.com>"

# sshd
RUN apk add --no-cache openssh && ssh-keygen -A
COPY sshd_config /etc/ssh/

# tor
RUN apk add --no-cache tor && rm -rf /etc/tor/torrc*
COPY torrc.default /etc/tor/

# user
RUN adduser -D -g "" -h /home/gof -s /bin/sh gof && \
    echo "gof:" | chpasswd && \
    echo "AllowUsers gof" >> /etc/ssh/sshd_config

# tools
RUN apk add --no-cache curl

EXPOSE 22

COPY run.sh renew /
CMD ["/run.sh"]
