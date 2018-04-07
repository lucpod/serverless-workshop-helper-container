FROM ubuntu:16.04

MAINTAINER "Luciano Mammino (@loige) & Padraig O'Brien (@Podgeypoos79)"
LABEL version="1.2.2" \
      maintainer="Luciano Mammino (@loige) & Padraig O'Brien (@Podgeypoos79)" \
      repository="https://github.com/lucpod/serverless-workshop-helper-container"

# Install python & utils
RUN apt-get update; \
    apt-get install -y \
      curl \
      vim \
      tmux \
      apt-transport-https \
      python-setuptools \
      python-dev \
      python-pip \
      python-software-properties \
      build-essential \
      software-properties-common \
      git; \
      rm -rf /var/lib/apt/lists/*

# Install Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -; \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable";  \
    apt-get update; \
    apt-cache policy docker-ce; \
    apt-get install -y docker-ce; \
    rm -rf /var/lib/apt/lists/*

# Install aws-cli
RUN pip install --upgrade pip
RUN pip install awscli

# Install node with n
RUN curl -L https://git.io/n-install | bash -s -- -y 8.10
ENV HOME "/root"
ENV N_PREFIX "${HOME}/n"
ENV PATH "${N_PREFIX}/bin:${PATH}"

# Install aws-sam-local
RUN curl -L -O https://github.com/awslabs/aws-sam-local/releases/download/v0.2.10/sam_0.2.10_linux_amd64.tar.gz; \
    tar xvzf sam_0.2.10_linux_amd64.tar.gz; \
    mv sam /usr/local/bin; \
    rm -rf sam_0.2.10_linux_amd64.tar.gz

# Install NPM utils (json-dynamo-putrequest, lambda-local)
RUN N_PREFIX="/root/n" PATH="/root/n/bin:${PATH}" npm install -g \
    json-dynamo-putrequest \
    lambda-local

# Copy custom entrypoint
COPY entrypoint.sh /var/entrypoint.sh
RUN chmod +x /var/entrypoint.sh

# Copy templates
RUN mkdir /root/templates
COPY templates/* /root/templates/

WORKDIR "/home"

ENTRYPOINT ["/var/entrypoint.sh"]
