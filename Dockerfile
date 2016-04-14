FROM gentoo/stage3-amd64

RUN emerge-webrsync
RUN eselect news read

RUN echo 'EMERGE_DEFAULT_OPTS="--ask=n --quiet --jobs=2"' >> /etc/portage/make.conf
RUN echo 'FEATURES="unknown-features-warn parallel-fetch parallel-install"' >> /etc/portage/make.conf

ADD . /overlay
RUN echo 'PORTDIR_OVERLAY=/overlay' >> /etc/portage/make.conf
