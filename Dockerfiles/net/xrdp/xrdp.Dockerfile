ARG IMAGE_BASE
FROM ${IMAGE_BASE}

ARG root_pwd=root_123

COPY ./scripts/*.sh /tmp

# install xrdp dependencies
RUN apt -y install xrdp xfce4-session xfce4-goodies xfce4 && \
    apt -y install ubuntu-desktop xubuntu-desktop && \

# xfce
    echo "xfce4-session" > ${HOME}/.xsession && \

# /etc/xrdp/startwm.sh
## https://codeantenna.com/a/qhfc1fiO7Y
    sed -i "s#test -x#\nunset DBUS_SESSION_BUS_ADDRESS\nunset XDG_RUNTIME_DIR\ntest -x#g" /etc/xrdp/startwm.sh && \

# start
    echo "nohup sh -c \"sleep 3 && xrdpstart >> /tmp/xrdp.log\" 2>&1 &" >> /init-service && \

# scripts
    mv /tmp/xrdp-restart.sh /usr/local/bin/xrdprestart && \
    mv /tmp/xrdp-start.sh /usr/local/bin/xrdpstart && \
    mv /tmp/xrdp-stop.sh /usr/local/bin/xrdpstop && \
    chmod +x /usr/local/bin/xrdprestart && chmod +x /usr/local/bin/xrdpstart && chmod +x /usr/local/bin/xrdpstop && \

# root pwd
    apt -y install passwd && \
    echo root:${root_pwd} | chpasswd