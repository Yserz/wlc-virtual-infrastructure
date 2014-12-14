FROM centos:centos7

MAINTAINER Michael Koppen <michael.koppen@googlemail.com>

#ENV container docker

# Update without kernel
#RUN yum -y -q -x 'kernel*' update

# Installing Utilities
# ---------------------*
RUN yum -y -q install hostname sudo passwd

# Creating Global Users
# ---------------------*
RUN useradd -s /bin/nologin logger

# Install runit
# ---------------------*
RUN curl https://packagecloud.io/install/repositories/imeyer/runit/script.rpm | /bin/sh > /dev/null 2>&1
RUN yum -y -q install runit-2.1.2-1.el7.centos.x86_64
# Config runit
ADD build/runit/ /etc/runit/

# Install cronie
# ---------------------
RUN yum install -y -q cronie
# Remove useless cron entries.
#RUN rm -f /etc/cron.daily/standard
# ********************* TODO
# Register in runit
#RUN mkdir /etc/service/crond
#ADD /build/runit/cron /etc/service/crond/run
#RUN chown root.root /etc/service/crond/run; \
#	chmod 750 /etc/service/crond/run

# Install rsyslog
# ---------------------
RUN yum install -y -q rsyslog
# modify rsyslog.conf http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/
ADD /build/config/rsyslog_default /etc/rsyslog.conf
# *********************
# Register service in runit
RUN mkdir -p /etc/service/rsyslogd
ADD /build/runit/rsyslogd /etc/service/rsyslogd/run
RUN chown root.root /etc/service/rsyslogd/run; \
	chmod 750 /etc/service/rsyslogd/run

# Install SSH Server
# ---------------------*
RUN yum install -y -q openssh-server
RUN mkdir -p /var/run/sshd
ADD /build/config/sshd_config /etc/ssh/sshd_config
# Generating standard RSA, DSA and ECDSA keys
# TODO ONBUILD ??
RUN ssh-keygen -A

# *********************
# Register service in runit
RUN mkdir -p /etc/service/sshd
ADD /build/runit/sshd /etc/service/sshd/run
RUN chown root.root /etc/service/sshd/run; \
	chmod 750 /etc/service/sshd/run
# *********************
# Register logger in runit
RUN mkdir -p /var/log/service/sshd
ADD /build/runit/log/sshd /etc/service/sshd/log/run
RUN chown logger /var/log/service/sshd; \
	chmod 750 /var/log/service/sshd; \
	chown logger /etc/service/sshd/log/run; \
	chmod 750 /etc/service/sshd/log/run

# *********************
# Creating Vagrant SSH Account
ADD key.pub /tmp/key.pub
RUN groupadd \
	--gid 1000 \
	--system \
	vagrant; \
	useradd \
	--uid 1000 \
	--gid 1000 \
	--home /home/vagrant \
	--shell /bin/bash vagrant; \
#	passwd -u vagrant; \
	echo vagrant | passwd --stdin vagrant; \
	mkdir /home/vagrant/.ssh; \
	touch /home/vagrant/.ssh/authorized_keys; \
	chown -R vagrant /home/vagrant/.ssh; \
	chmod -R go-rwsx /home/vagrant/.ssh; \
	chmod 600 /tmp/key.pub; \ 
	cat /tmp/key.pub >> /home/vagrant/.ssh/authorized_keys; \ 
	rm -f /tmp/key.pub; \
	echo "%vagrant ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/vagrant; \
	sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

RUN yum clean all

CMD ["/usr/sbin/runsvdir-start"]
EXPOSE 22