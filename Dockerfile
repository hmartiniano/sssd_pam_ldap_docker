FROM ubuntu:xenial

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update 
RUN apt-get -y install apt-utils 
RUN apt-get -y upgrade
RUN apt-get -y install \
            vim \
            htop \
            sudo \
            supervisor \
            software-properties-common \
            && apt-get autoclean

RUN add-apt-repository ppa:gluster/glusterfs-3.12
RUN add-apt-repository ppa:gluster/nfs-ganesha-2.6
RUN add-apt-repository ppa:gluster/libntirpc-1.6
RUN apt-get update
RUN apt-get -y install \
        krb5-user samba sssd ntp \
        libpam-sss libnss-sss \
        ldap-utils \
        sssd-tools \
        glusterfs-client \
        glusterfs-server \
        nfs-ganesha \ 
        ctdb \ 
        rsyslog \
        openssh-server 

#ADD sssd.conf /etc/sssd/sssd.conf
#ADD krb5.conf /etc/krb5.conf
#RUN chmod 0600 /etc/sssd/sssd.conf
RUN rm /etc/krb5.conf
RUN mkdir -p /etc/krb5
RUN mkdir -p /var/run/sshd
RUN echo "session required    pam_mkhomedir.so skel=/etc/skel umask=0077" >> /etc/pam.d/common-session

EXPOSE 22
EXPOSE 135
EXPOSE 137
EXPOSE 138
EXPOSE 139
EXPOSE 445

COPY etc/supervisor /etc/supervisor
COPY etc/samba/smb.conf /etc/samba/smb.conf
CMD ["/usr/bin/supervisord"]

