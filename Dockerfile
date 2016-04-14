FROM tharvik/gentoo-git

ADD . /overlay
RUN echo 'PORTDIR_OVERLAY=/overlay' >> /etc/portage/make.conf
