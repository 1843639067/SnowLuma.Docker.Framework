dockerfile
FROM ghcr.io/napneko/napcat-docker:latest
RUN mkdir -p /opt/napcat-backup && \
    cp -r /app/napcat /opt/napcat-backup/
RUN echo '#!/bin/bash' > /railway-entrypoint.sh && \
    echo 'if [ ! -f /app/napcat/napcat.mjs ]; then' >> /railway-entrypoint.sh && \
    echo '    mkdir -p /app/napcat' >> /railway-entrypoint.sh && \
    echo '    cp -r /opt/napcat-backup/napcat/* /app/napcat/' >> /railway-entrypoint.sh && \
    echo 'fi' >> /railway-entrypoint.sh && \
    echo 'exec "$@"' >> /railway-entrypoint.sh && \
    chmod +x /railway-entrypoint.sh

ENTRYPOINT ["/railway-entrypoint.sh"]
CMD ["/entrypoint.sh"]
