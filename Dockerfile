FROM alpine:3.18

ENV TZ="Asia/Shanghai"

ARG TARGETOS
ARG TARGETARCH

COPY ./script/entrypoint.sh /entrypoint.sh

RUN apk update && \
    apk add ca-certificates tzdata && \
    export TZ=$TZ && \
    ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && \
    date && \
    chmod +x /entrypoint.sh

WORKDIR /dashboard
COPY ./resource ./resource
COPY ./dashboard-${TARGETOS}-${TARGETARCH} ./app

VOLUME ["/dashboard/data"]
EXPOSE 80 5555
ENTRYPOINT ["/entrypoint.sh"]
