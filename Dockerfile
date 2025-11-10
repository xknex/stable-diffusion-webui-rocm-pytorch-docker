FROM rocm/pytorch:rocm7.1_ubuntu22.04_py3.10_pytorch_release_2.8.0


# Install/upate software
RUN apt update && apt upgrade -y && apt dist-upgrade -y && apt install google-perftools libgoogle-perftools-dev bc -y
RUN echo 'PATH=/usr/local/bin:$PATH' >> /etc/bash.bashrc
RUN PATH=/usr/local/bin:$PATH

# Non-root user
RUN adduser -u 1001 --disabled-password --gecos "" dockerx
USER dockerx

# Fix for many GPUs. Try without if you have problems.
ENV HIP_VISIBLE_DEVICES=0

# Run post-build script
WORKDIR /dockerx
CMD ["./bootstrap.sh"]