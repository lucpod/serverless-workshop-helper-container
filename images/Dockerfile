FROM ubuntu:16.04

# Install python & utils
RUN apt-get update; \
    apt-get install -y \
      curl \
      python-setuptools \
      python-dev \
      python-pip build-essential \
      git; \
      rm -rf /var/lib/apt/lists/*

# Install aws-cli
RUN pip install --upgrade pip
RUN pip install awscli

# Install node with n
RUN curl -L https://git.io/n-install | bash -s -- -y 6.10.3
ENV HOME="/root"
ENV N_PREFIX="${HOME}/n"
ENV PATH="${N_PREFIX}/bin:${PATH}"

# Install go
RUN cd $HOME; \
    curl -O https://storage.googleapis.com/golang/go1.10.linux-amd64.tar.gz; \
    tar xvf go1.10.linux-amd64.tar.gz; \
    rm -rf go1.10.linux-amd64.tar.gz; \
    mkdir /root/gopath; \
    echo "export GOROOT=/root/go" >> /root/.bashrc; \
    echo "export GOPATH=/root/gopath" >> /root/.bashrc; \
    echo "export PATH=/root/gopath/bin:/root/go/bin:${PATH}" >> /root/.bashrc
ENV GOROOT="${HOME}/go"
ENV GOPATH="${HOME}/gopath"
ENV PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"

# Install aws-sam-local
RUN GOROOT="/root/go" GOPATH="/root/gopath" PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}" go get github.com/awslabs/aws-sam-local; \
    ln -s /root/gopath/bin/aws-sam-local /root/gopath/bin/sam
