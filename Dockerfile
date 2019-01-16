FROM kong:0.14

WORKDIR /

COPY "kong-plugin-custom-request-transformer-0.1.0-1.all.rock" .
RUN ["luarocks", "install", "kong-plugin-custom-request-transformer-0.1.0-1.all.rock"]

ENV KONG_PLUGINS="bundled,custom-request-transformer"

CMD ["kong", "start"]