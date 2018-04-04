# 📦 serverless-workshop-helper-container

[![CircleCI](https://circleci.com/gh/lucpod/serverless-workshop-helper-container.svg?style=shield)](https://circleci.com/gh/lucpod/serverless-workshop-helper-container)
[![Docker Stars](https://img.shields.io/docker/stars/lucpod/workshop.svg)](https://hub.docker.com/r/lucpod/workshop/)
[![Docker Pulls](https://img.shields.io/docker/pulls/lucpod/workshop.svg)](https://hub.docker.com/r/lucpod/workshop/)


A helper Docker image that has all the software for running [LucPod workshops](https://github.com/lucpod) pre-installed

The image comes with the following software pre-installed:

  - Docker:    `18.03.0-ce`
  - Node.js:   `8.10.0`
  - NPM:       `5.6.0`
  - Python:    `2.7.12`
  - PIP:       `9.0.3`
  - Go:        `1.10`
  - SAM local: `snapshot`
  - AWS CLI:   `1.14.68`

This way you don't have to install all of those manually in your machine!


## 🤓 The "easy" way with Docker compose

The easiest way to use this container image is with [Docker compose](https://docs.docker.com/compose),
you can easily get started by pulling a sample compose file directly into your workspace directory:

```bash
curl -O https://raw.githubusercontent.com/lucpod/serverless-workshop-helper-container/master/docker-compose.yml
```

You will also need the `.env` file to define the configuration variables:

```bash
curl -o .env https://raw.githubusercontent.com/lucpod/serverless-workshop-helper-container/master/.env~SAMPLE
```

Now edit your `.env` file and, finally, run the container with:

```bash
docker-compose up -d
docker-compose exec workshop bash
```

This way you don't have to digit again all your config everytime you want to run the
container.

Don't forget to stop the container when you are finished:

```bash
docker-compose down
```

That's everything you need to know to be proficient with the image. Anyway, if you
would like to understand more the internals or use the image without Docker compose,
keep reading this documentation.


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
  -v /path/to/my/local/working-dir/:/home \
  lucpod/workshop
```


### 💪 Configure Docker daemon

At some point in the workshop you might need to use tools based on Docker like
SAM Local. To enable the container to spin up other containers in the host machine,
you have to run the container with the following volume.
When using SAM Local, since the SAM container will be started in the main Docker environment
(the host machine in most systems), you will need to know the path of your project in the
host machine. An easy way to do that is to pass it during container bootstrap as an
environment variable, like `PARENT_PWD`. This configuration will look like this:

```bash
docker run -it \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -e PARENT_PWD=$(pwd) \
  lucpod/workshop
```

or, **if you are on Windows**:

```bash
docker run -it \
  -v //var/run/docker.sock:/var/run/docker.sock \
  -e PARENT_PWD=$(pwd) \
  lucpod/workshop
```

Notice the double slash (`//`) at the beginning of the volume path.

With this setup, when inside the container, you can reference the `PWD` in the host
machine with the environment variable `$PARENT_PWD` and use the docker daemon from
the host machine too.


## 🚪 Open ports for SAM local

Tools like SAM Local will open ports to expose specific services. For instance the
`start-api` functionality of SAM Local will create an API Gateway on port `3000`. If you want to
expose this port on your host machine too (so that you can use your favorite API client),
you can do it with the `-p` flag:

```bash
docker run -it \
  -p 3000:3000 \
  lucpod/workshop
```


### 🤙 Full ideal run config

Ideally you should pass all the parameters and obtain the following configuration:

```bash
docker run -it \
  -e AWS_ACCESS_KEY_ID="XXXX" \
  -e AWS_SECRET_ACCESS_KEY="YYYY" \
  -e AWS_REGION="eu-west-1" \
  -e AWS_OUTPUT_FORMAT="json" \
  -e PARENT_PWD=$(pwd) \
  -p 3000:3000 \
  -v /path/to/my/local/working-dir/:/home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  lucpod/workshop
```

Be sure to change all the parameters according to your configuration.


## 👯‍ Contributing

Everyone is very welcome to contribute to this project.
You can contribute just by submitting bugs or suggesting improvements by
[opening an issue on GitHub](https://github.com/lucpod/serverless-workshop-helper-container/issues).


## 🤦‍ License

Licensed under [MIT License](https://github.com/lucpod/serverless-workshop-helper-container/LICENSE). © LucPod.
