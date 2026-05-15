FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV GITEA_RUNNER_VERSION=0.2.12

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    git \
    jq \
    unzip \
    sudo \
    python3 \
    python3-pip \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

RUN groupadd docker || true

RUN useradd -m runner && usermod -aG docker runner

WORKDIR /runner

RUN curl -L \
    -o act_runner \
    https://dl.gitea.com/act_runner/${GITEA_RUNNER_VERSION}/act_runner-${GITEA_RUNNER_VERSION}-linux-amd64 \
    && chmod +x act_runner


RUN mkdir -p /workspace /cache /data && \
    chown -R runner:runner /runner /workspace /cache /data

ENV PATH="/home/runner/.local/bin:${PATH}"

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

USER runner

ENTRYPOINT ["/entrypoint.sh"]
