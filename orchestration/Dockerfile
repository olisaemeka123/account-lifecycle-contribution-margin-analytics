FROM astrocrpublic.azurecr.io/runtime:3.3-2

USER root
RUN export SHELL=/bin/bash && \
    curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | sh -s -- --update && \
    DBT_PATH=$(find /root -maxdepth 5 -name dbt -type f 2>/dev/null | head -n1) && \
    cp "$DBT_PATH" /usr/local/bin/dbt && \
    chmod +rx /usr/local/bin/dbt
USER astro