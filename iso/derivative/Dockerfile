# Let's copy over luet from official images. 
# This version will be used to bootstrap luet itself and Elemental internal components
ARG LUET_VERSION=0.32.0
FROM quay.io/luet/base:$LUET_VERSION AS luet

FROM registry.suse.com/suse/sle-micro-rancher/5.2
ARG K3S_VERSION=v1.20.4+k3s1
ARG ARCH=amd64
ENV ARCH=${ARCH}


# Copy the luet config file pointing to the upgrade repository
COPY repositories.yaml /etc/luet/luet.yaml

# Copy luet from the official images
COPY --from=luet /usr/bin/luet /usr/bin/luet
RUN rm /var/lock && mkdir /var/lock && luet install -y \
       toolchain/yip \
       toolchain/luet \
       utils/installer \
       system/cos-setup \
       system/immutable-rootfs \
       system/grub2-config \
       system/base-dracut-modules

# Install k3s server/agent
ENV INSTALL_K3S_VERSION=${K3S_VERSION}
RUN curl -sfL https://get.k3s.io > installer.sh && \
    INSTALL_K3S_SKIP_START="true" INSTALL_K3S_SKIP_ENABLE="true" sh installer.sh && \
    INSTALL_K3S_SKIP_START="true" INSTALL_K3S_SKIP_ENABLE="true" sh installer.sh agent && \
    rm -rf installer.sh

## System layout

# Required by k3s etc.
RUN mkdir /usr/libexec && touch /usr/libexec/.keep

# Copy custom files
# COPY files/ /

# Copy cloud-init default configuration
COPY cloud-init.yaml /system/oem/

# Generate initrd
RUN mkinitrd

# OS level configuration
RUN echo "VERSION=999" > /etc/os-release
RUN echo "GRUB_ENTRY_NAME=derivative" >> /etc/os-release
RUN echo "welcome to our derivative" >> /etc/issue.d/01-derivative

# Copy cloud-init default configuration
COPY cloud-init.yaml /system/oem/
