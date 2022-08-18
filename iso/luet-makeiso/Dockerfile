FROM quay.io/costoolkit/toolchain
RUN zypper install -y squashfs xorriso && echo -e '\
name: "luet"\n\
description: "Luet official Repository"\n\
type: "http"\n\
enable: true\n\
cached: true\n\
priority: 1\n\
urls:\n\
- "https://raw.githubusercontent.com/Luet-lab/luet-repo/gh-pages"\
' > /etc/luet/repos.conf.d/luet-official.yaml && luet install --yes extension/makeiso
ENTRYPOINT /usr/bin/luet-makeiso
WORKDIR /cOS
