FROM ubuntu:trusty

# Edit the yum_updated label to force a yum update of the image
LABEL apt_updated="20171006"

RUN apt-get update

RUN apt-get install -y \
		g++ \
		pkg-config \
		cmake \
		libfftw3-dev \
		libpolarssl-dev \
		libboost-all-dev \
		libconfig++-dev \
		libsctp-dev \
		gnuradio-dev \
		uhd-host \
		libuhd-dev \
		bladerf-host \
		libbladerf-dev

COPY ./ /src/

RUN mkdir /src/build && \
		cd /src/build && \
		cmake .. && \
		make && \
		make test && \
		make install && \
		ldconfig
