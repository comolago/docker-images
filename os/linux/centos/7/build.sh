#!/bin/bash
export CENTOS_ROOT='/centos_image/rootfs'
mkdir -p ${CENTOS_ROOT}
rpm --root ${CENTOS_ROOT} --initdb
yum reinstall --downloadonly --downloaddir . centos-release
rpm --nodeps --root ${CENTOS_ROOT} -ivh centos-release*.rpm
rpm --root ${CENTOS_ROOT} --import  ${CENTOS_ROOT}/etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
yum -y --installroot=${CENTOS_ROOT} --setopt=tsflags='nodocs' --setopt=override_install_langs=en_US.utf8 install yum
sed -i "/distroverpkg=centos-release/a override_install_langs=en_US.utf8\ntsflags=nodocs" ${CENTOS_ROOT}/etc/yum.conf
mknod -m 644 ${CENTOS_ROOT}/dev/urandom c 1 9
cp /etc/resolv.conf ${CENTOS_ROOT}/etc
chroot ${CENTOS_ROOT} /bin/bash <<EOF
yum install -y procps-ng iputils
yum clean all
EOF
chroot ${CENTOS_ROOT} /bin/bash <<EOF
rpm --initdb
EOF
rm -f ${CENTOS_ROOT}/etc/resolv.conf
export CENTOS_VERSION=$(sed 's/.*release [ ]*\([0-9\.]*\) .*/\1/' ${CENTOS_ROOT}/etc/centos-release |cut -d . -f1,2)
tar -C ${CENTOS_ROOT} -c . | docker import - centos:${CENTOS_VERSION}
