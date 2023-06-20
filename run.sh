#!/bin/sh

set -ex

#docker build -t ghcr.io/mgoltzsche/stable-diffusion .
make image
mkdir -p models
docker run --rm \
	--mount type=bind,src=`pwd`/models,dst=/stable-diffusion/models \
	ghcr.io/mgoltzsche/stable-diffusion \
	--prompt "a photograph of an astronaut riding a horse" --plms
