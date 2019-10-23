FROM openjdk:jre-alpine

LABEL MAINTAINER=pradeepnnv

### Initialize Variables
ARG USER=hsp
ARG GROUP=hsp
ARG UID=1000
ARG GID=1000
ARG HTTP_PORT=8080

ARG APPLICATION_JAR
ARG APPLICATION_DIR=/opt/hello-world-sb

#Set environment variable
ENV APPLICATION_DIR=${APPLICATION_DIR}
ENV APPLICATION_JAR=${APPLICATION_JAR}


RUN mkdir -p ${APPLICATION_DIR} \
    && chown ${UID}:${GID} $APPLICATION_DIR \
    && addgroup -g $GID -S $GROUP \
    && adduser -u $UID -G $GROUP -H -D -S $USER

COPY target/${APPLICATION_JAR} ${APPLICATION_DIR}/myproject.jar
COPY start.sh ${APPLICATION_DIR}/

RUN chmod +x ${APPLICATION_DIR}/start.sh

EXPOSE $HTTP_PORT

USER $USER

CMD ["/bin/sh", "-c", "${APPLICATION_DIR}/start.sh"]
