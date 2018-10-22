FROM library/golang:1.11
ARG INSTALL_PATH

LABEL maintainer="Marco Antonio Carcano <mc@carcano.coh>"
ENV INSTALL_PATH=${INSTALL_PATH}
ENV GOBIN=${INSTALL_PATH}/bin
ENV DEFAULT_HOME=/home/default
ENV GOPATH=${DEFAULT_HOME}

LABEL io.k8s.description="Platform for building Go applications" \
      io.k8s.display-name="GO 1.11" \
      io.openshift.tags="builder,go,go1.11" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.s2i.scripts-url="image:///usr/libexec/s2i"

RUN useradd -u 1001 -g 0 -c "Default Application User" -s /sbin/nologin -d ${DEFAULT_HOME} default && \
mkdir -p ${GOPATH} ${INSTALL_PATH} && \
chown -R 1001:0 ${DEFAULT_HOME} && \
chown -R 1001:0 ${INSTALL_PATH}

COPY ./s2i/bin/ /usr/libexec/s2i

USER 1001

CMD ["/usr/libexec/s2i/usage"]
