# 📦 serverless-workshop-helper-container

[![CircleCI](https://circleci.com/gh/lucpod/serverless-workshop-helper-container.svg?style=shield)](https://circleci.com/gh/lucpod/serverless-workshop-helper-container)
[![Docker Stars](https://img.shields.io/docker/stars/lucpod/workshop.svg)](https://hub.docker.com/r/lucpod/workshop/)
[![Docker Pulls](https://img.shields.io/docker/pulls/lucpod/workshop.svg)](https://hub.docker.com/r/lucpod/workshop/)


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

> ⚠️ In reality you will need to tweak the Docker container config a bit in order to be
> fully operative for the workshops, so keep reading the following sections!


### ✍️ Configure AWS CLI automatically

When the container starts it will try to automatically configure the AWS CLI based on
some environment variables that should be passed during the initialization:

- `AWS_ACCESS_KEY_ID`: AWS access id for your user
- `AWS_SECRET_ACCESS_KEY`: AWS secret access key for your user
- `AWS_REGION`: (optional) The AWS region (default: `eu-west-1`)
- `AWS_OUTPUT_FORMAT`: (optional) The AWS console preferred output (default: `json`)

To pass environment variables while running the container you should use the `-e` flag:

```bash
docker run -it \
  -e AWS_ACCESS_KEY_ID="XXXX" \
  -e AWS_SECRET_ACCESS_KEY="YYYY" \
  -e AWS_REGION="eu-west-1" \
  -e AWS_OUTPUT_FORMAT="json" \
  lucpod/workshop
```


### 🤝 Share working directory

Very ofter you will have all the files for your work in progress workshop in your
local machine (so that you can use your favorite editor and tools), so you will need
to share the working directory by mounting it into the container.

You can do that with the `-v` (volume) option

```bash
docker run -it \
  -v /path/to/my/local/working-dir/:/home/workshop
  lucpod/workshop
```


### 💪 Configure Docker daemon

At some point in the workshop you might need to use tools based on Docker like
SAM Local. To enable the container to spin up other containers in the host machine,
you have to run the container with the following volume:

```bash
docker run -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  lucpod/workshop
```

or, **if you are on Windows**:

```bash
docker run -it \
  -v //var/run/docker.sock:/var/run/docker.sock \
  lucpod/workshop
```

Notice the double slash (`//`) at the beginning of the path


### 🤙 Full ideal run config

Ideally you should pass all the parameters and obtain the following configuration:

```bash
docker run -it \
  -e AWS_ACCESS_KEY_ID="XXXX" \
  -e AWS_SECRET_ACCESS_KEY="YYYY" \
  -e AWS_REGION="eu-west-1" \
  -e AWS_OUTPUT_FORMAT="json" \
  -v /path/to/my/local/working-dir/:/home/workshop \
  -v /var/run/docker.sock:/var/run/docker.sock \
  lucpod/workshop
```

Be sure to change all the parameters according to your configuration.


### 🤲 All in one with Docker Compose

If you prefer to use [Docker compose](https://docs.docker.com/compose), you can easily get started by pulling a sample compose file
directly into your workspace directory:

```bash
curl -O https://raw.githubusercontent.com/lucpod/serverless-workshop-helper-container/master/docker-compose.yml
```

You will also need the `.env` file to define the configuration variables:

```bash
curl -o .env https://raw.githubusercontent.com/lucpod/serverless-workshop-helper-container/master/.env~SAMPLE
```

Now edit your `.env` file and, finally, run the container with:

```bash
docker-compose up workshop
```


## 👯‍ Contributing

Everyone is very welcome to contribute to this project.
You can contribute just by submitting bugs or suggesting improvements by
[opening an issue on GitHub](https://github.com/lucpod/serverless-workshop-helper-container/issues).


## 🤦‍ License

Licensed under [MIT License](LICENSE). © LucPod.
