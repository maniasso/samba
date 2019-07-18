FROM alpine
#MAINTAINER David Personette <dperson@gmail.com>

# Install samba
RUN apk --no-cache --no-progress upgrade && \
    apk --no-cache --no-progress add bash samba shadow tini && \
#    adduser -D -G users -H -S -g 'Samba User' -h /tmp smbuser && \
    rm -rf /tmp/*

COPY smb.conf /etc/samba/
COPY samba.sh /usr/bin/

RUN mkdir /public

EXPOSE 137/udp 138/udp 139 445

HEALTHCHECK --interval=60s --timeout=15s \
            CMD smbclient -L '\\localhost' -U '%' -m SMB3

VOLUME ["/etc", "/var/cache/samba", "/var/lib/samba", "/var/log/samba",\
            "/run/samba"]

ENTRYPOINT ["/sbin/tini", "--", "/usr/bin/samba.sh"]
