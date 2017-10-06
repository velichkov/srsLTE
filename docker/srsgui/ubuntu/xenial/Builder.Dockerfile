FROM srsgui-builder-ubuntu-xenial

RUN apt-get update && apt-get install -y \
		g++ \
		pkg-config \
		cmake \
		libfftw3-dev \
		libmbedtls-dev \
		libboost-system1.58-dev \
		libboost-program-options1.58-dev \
		libconfig++-dev \
		libsctp-dev \
		gnuradio-dev \
		uhd-host \
		libuhd-dev \
		bladerf-host \
		libbladerf-dev

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
