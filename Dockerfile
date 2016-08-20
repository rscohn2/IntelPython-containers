# Latest Ubuntu LTS with intel python
FROM ubuntu:latest
MAINTAINER Robert Cohn <Robert.S.Cohn@intel.com>

RUN apt-get update && apt-get install -y \
    bzip2 \
    wget

ARG MINICONDA=/usr/local/miniconda3
ARG PYVER=3

# We need conda to install intelpython, so install miniconda
RUN cd /tmp \
    && wget -q https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x /tmp/Miniconda3-latest-Linux-x86_64.sh \
    && /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p $MINICONDA \
    && rm /tmp/Miniconda3-latest-Linux-x86_64.sh \
    && $MINICONDA/bin/conda update -q conda

# Create IDP environment
RUN $MINICONDA/bin/conda config --add channels intel \
    && ACCEPT_INTEL_PYTHON_EULA=yes $MINICONDA/bin/conda create -y -n idp intelpython${PYVER}_core python=${PYVER}