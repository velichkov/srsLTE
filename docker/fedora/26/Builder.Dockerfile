FROM fedora:26

# Edit the yum_updated label to force a yum update of the image
LABEL yum_updated="20171006"

RUN dnf -y update 

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

COPY ./ /src/

RUN mkdir /src/build && \
		cd /src/build && \
		cmake .. && \
		make && \
		make test && \
		make install && \
		ldconfig
