# serverless-workshop-helper-container

[![CircleCI](https://circleci.com/gh/lucpod/serverless-workshop-helper-container.svg?style=shield)](https://circleci.com/gh/lucpod/serverless-workshop-helper-container)
[![Docker Stars](https://img.shields.io/docker/stars/lucpod/workshop.svg)](https://hub.docker.com/r/lucpod/workshop/)


A helper Docker image that has all the software for running [LucPod workshops](https://github.com/lucpod) pre-installed

The image comes with the following software pre-installed:

  - Docker:    `18.03.0-ce`
  - Node.js:   `6.10.3`
  - NPM:       `3.10.10`
  - Python:    `2.7.12`
  - PIP:       `9.0.3`
  - Go:        `1.10`
  - SAM local: `snapshot`
  - AWS CLI:   `1.14.68`

This way you don't have to install all of those manually in your machine!


## 👇 Pull the image

To pull the image from Docker Hub run:

```bash
docker pull lucpod/workshop
```

Sit tight and be patient, when the download finish you can use the docker image!


## 🤞 Use the image

The simplest way to use the image is to just run:

```bash
docker run -it lucpod/workshop
```

This will start a Docker container in interactive mode with a bash console ready to be used.
In this console you will have access to all the afore mentioned software.

In reality you will need to tweak the Docker container config a bit in order to be
fully operative for the workshops, so keep reading the following sections!


### ✍️ Configure AWS CLI automatically

TODO


### 🤝 Share working directory

TODO


### 💪 Configure Docker daemon

TODO

```bash
docker run -v /var/run/docker.sock:/var/run/docker.sock ...
```


### 🤙 Full ideal run config

TODO


### 🤲 All in one with Docker Compose

TODO


## 👯‍ Contributing

Everyone is very welcome to contribute to this project.
You can contribute just by submitting bugs or suggesting improvements by
[opening an issue on GitHub](https://github.com/lucpod/serverless-workshop-helper-container/issues).


## 🤦‍ License

Licensed under [MIT License](LICENSE). © LucPod.
