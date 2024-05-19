FROM traefik:picodon

LABEL maintainer="shunt"

CMD ["traefik"]
COPY root/ /

RUN apk update && \
    apk upgrade
RUN chmod +x /init.sh

ENTRYPOINT ["/init.sh", "/entrypoint.sh"]