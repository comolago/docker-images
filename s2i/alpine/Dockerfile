FROM library/alpine
LABEL maintainer="Marco Antonio Carcano <mc@carcano.coh>"

ENV INSTALL_PATH="/opt/app-root"
LABEL io.k8s.description="Alpine Runtime Platform" \
      io.k8s.display-name="Alpine Runtime" \
      io.openshift.tags="runtime,alpine" \
      io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.s2i.scripts-url="image:///usr/libexec/s2i" \
      io.openshift.s2i.assemble-input-files="${INSTALL_PATH}"
RUN mkdir -p /home/default && \
adduser -D -u 1001 -g "Default Application User" -s /sbin/nologin -h /home/default default && \
chown -R 1001:0 /home/default && \
mkdir /lib64 && \
ln -s /lib/libc.musl-x86_64.so.1  /lib64/ld-linux-x86-64.so.2

COPY ./s2i/bin/ /usr/libexec/s2i

USER 1001

WORKDIR /opt

CMD ["/usr/libexec/s2i/usage"]
