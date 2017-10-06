FROM srsgui-builder-fedora-26:latest

RUN dnf install -y \
		gcc-c++ \
		make \
		pkgconfig \
		cmake \
		mbedtls-devel \
		fftw-devel \
		boost-devel \
		libconfig-devel \
		lksctp-tools-devel \
		uhd-firmware \
		uhd-devel \
		gnuradio-devel

USER srs
WORKDIR /home/srs
COPY ./ srsLTE/

RUN mkdir srsLTE_build && cd srsLTE_build && \
		cmake ../srsLTE && \
		make && \
		make test

USER root
RUN cd srsLTE_build && \
	make install && \
	ldconfig
