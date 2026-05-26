FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      openssh-server \
      ca-certificates \
      git \
      rsync \
      curl \
      tini && \
    mkdir -p /run/sshd /root/.ssh /workspace && \
    chmod 700 /root/.ssh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22
VOLUME ["/workspace"]
WORKDIR /workspace

COPY start-sshd.sh /usr/local/bin/start-sshd.sh
RUN chmod +x /usr/local/bin/start-sshd.sh

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["/usr/local/bin/start-sshd.sh"]
