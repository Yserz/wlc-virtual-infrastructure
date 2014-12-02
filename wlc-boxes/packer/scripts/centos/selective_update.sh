#!/bin/sh

#  Paket                                                 Arch                                Version                                             Repository                           Grösse
# ==========================================================================================================================================================================================
# Installieren:
#  kernel                                                x86_64                              2.6.32-504.1.3.el6                                  updates                               29 M
# Aktualisieren:
#  curl                                                  x86_64                              7.19.7-40.el6_6.1                                   updates                              194 k
#  cyrus-sasl                                            x86_64                              2.1.23-15.el6_6.1                                   updates                               78 k
#  cyrus-sasl-lib                                        x86_64                              2.1.23-15.el6_6.1                                   updates                              136 k
#  device-mapper                                         x86_64                              1.02.90-2.el6_6.1                                   updates                              173 k
#  device-mapper-event                                   x86_64                              1.02.90-2.el6_6.1                                   updates                              122 k
#  device-mapper-event-libs                              x86_64                              1.02.90-2.el6_6.1                                   updates                              116 k
#  device-mapper-libs                                    x86_64                              1.02.90-2.el6_6.1                                   updates                              218 k
#  initscripts                                           x86_64                              9.03.46-1.el6.centos.1                              updates                              943 k
#  iproute                                               x86_64                              2.6.32-33.el6_6                                     updates                              365 k
#  kernel-firmware                                       noarch                              2.6.32-504.1.3.el6                                  updates                               14 M
#  kpartx                                                x86_64                              0.4.9-80.el6_6.1                                    updates                               62 k
#  libcurl                                               x86_64                              7.19.7-40.el6_6.1                                   updates                              166 k
#  libxml2                                               x86_64                              2.7.6-17.el6_6.1                                    updates                              801 k
#  lvm2                                                  x86_64                              2.02.111-2.el6_6.1                                  updates                              816 k
#  lvm2-libs                                             x86_64                              2.02.111-2.el6_6.1                                  updates                              901 k
#  mdadm                                                 x86_64                              3.3-6.el6_6.1                                       updates                              341 k
#  nss-softokn                                           x86_64                              3.14.3-18.el6_6                                     updates                              261 k
#  nss-softokn-freebl                                    x86_64                              3.14.3-18.el6_6                                     updates                              164 k
#  openssh                                               x86_64                              5.3p1-104.el6_6.1                                   updates                              272 k
#  openssh-clients                                       x86_64                              5.3p1-104.el6_6.1                                   updates                              437 k
#  openssh-server                                        x86_64                              5.3p1-104.el6_6.1                                   updates                              321 k
#  openssl                                               x86_64                              1.0.1e-30.el6_6.4                                   updates                              1.5 M
#  policycoreutils                                       x86_64                              2.0.83-19.47.el6_6.1                                updates                              650 k
#  rsyslog                                               x86_64                              5.8.10-9.el6_6                                      updates                              649 k
#  tzdata                                                noarch                              2014j-1.el6                                         updates                              445 k
#  wget                                                  x86_64                              1.12-5.el6_6.1                                      updates                              483 k
#
# Vorgangsübersicht
# ==========================================================================================================================================================================================
# Install       1 Package(s)
# Upgrade      26 Package(s)


yum -y update device-mapper openssh openssl wget tzdata initscripts

echo "Rebooting the machine..."
reboot
sleep 60