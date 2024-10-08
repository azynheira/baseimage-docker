ARG BASE_IMAGE=ubuntu:24.04
FROM $BASE_IMAGE

RUN mkdir /bd_build

COPY image/. /bd_build/

RUN /bd_build/prepare.sh 
RUN /bd_build/utilities.sh
RUN	/bd_build/cleanup.sh

ENV DEBIAN_FRONTEND="teletype" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

# Copy document LaTex document into container
COPY docs/* /tmp/

# Patch the relevant files
COPY latex_patches/* /tmp

# Change directory and 
WORKDIR "/tmp"

# ... Finally run make
RUN make fix_latex_files
RUN make

# Copy the result back to the host
# ADD /tmp/refman.pdf .

CMD ["/sbin/my_init"]
