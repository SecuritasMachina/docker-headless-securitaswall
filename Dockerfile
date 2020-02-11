# Headless Ubuntu VNC Container with xfce window manager, OpenJDK 8, Eclipse, Tomcat, MySQL, MySQL Workbench, Firefox
FROM ackdev/secure_proxy_securitas-wall-base-xfce:2020-02-11-r1

LABEL maintainer="Acknowledged Development Inc. help@ackdev.com"
MAINTAINER Acknowledged Development Inc. "help@ackdev.com"

LABEL io.k8s.description="Headless VNC Container with xfce window manager, OpenJDK 8, Eclipse, Tomcat, MySQL, MySQL Workbench, Firefox" \
      io.k8s.display-name="Headless Enterprise Developer VNC Container based on xfce" \
      io.openshift.expose-services="80:http,443:https, 22022:ssh" \
      io.openshift.tags="http, https, ssh" \
      io.openshift.non-scalable=true

ENV TERM=xterm \
	SHELL=/bin/bash
# Install Chrome
#RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#RUN dpkg -i google-chrome-stable_current_amd64.deb; apt-get -fy install

### Install security tools
RUN $INST_SCRIPTS/securityTools.sh

### Configure security
RUN $INST_SCRIPTS/applyHomePermissions.sh

### Configure storage
RUN $INST_SCRIPTS/configureStorage.sh

### configure startup
ADD ./src/common/scripts $STARTUPDIR

RUN $INST_SCRIPTS/applyHomePermissions.sh
RUN $INST_SCRIPTS/configureSecurity.sh $STARTUPDIR
ADD src/template/etc /etc
RUN $INST_SCRIPTS/finalizeSecurity.sh

### Finalize installation & clean-up
RUN $INST_SCRIPTS/finalize.sh

ENTRYPOINT ["/dockerstartup/entrypoint.sh"]
CMD ["--wait"]
