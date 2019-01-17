FROM kong:0.14

WORKDIR /

COPY "kong-plugin-replace-body-with-header-0.1.0-1.all.rock" .
RUN ["luarocks", "install", "kong-plugin-replace-body-with-header-0.1.0-1.all.rock"]

ENV KONG_PLUGINS="bundled,replace-body-with-header"

CMD ["kong", "start"]