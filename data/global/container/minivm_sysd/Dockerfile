FROM centos:centos7

MAINTAINER Michael Koppen <michael.koppen@googlemail.com>

# Installing Utilities
# ---------------------*
RUN yum -y install hostname sudo passwd initscripts

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; yum clean all; \ 
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \ 
rm -f /lib/systemd/system/multi-user.target.wants/*;\ 
rm -f /etc/systemd/system/*.wants/*;\ 
rm -f /lib/systemd/system/local-fs.target.wants/*; \ 
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \ 
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \ 
rm -f /lib/systemd/system/basic.target.wants/*;\ 
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install cron
# ---------------------
RUN yum install -y -q cronie

# Install rsyslog
# ---------------------
RUN yum install -y rsyslog
# modify rsyslog.conf http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/
ADD /build/config/rsyslog_default /etc/rsyslog.conf

RUN yum install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN ssh-keygen -A

# *********************
# Creating Vagrant SSH Account
ADD key.pub /tmp/key.pub
RUN groupadd \ 
	--gid 500 \ 
	--system \ 
	vagrant; \ 
	useradd \ 
	--uid 500 \ 
	--gid 500 \ 
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
	
#RUN systemctl enable sshd.service;

RUN yum clean all
# fix https://bugzilla.redhat.com/show_bug.cgi?id=1043212
# "System is booting up. See pam_nologin(8)"
RUN sed -i -r 's/^(.*pam_nologin.so)/#\1/' /etc/pam.d/sshd

EXPOSE 22
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]