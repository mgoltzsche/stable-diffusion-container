#!/bin/sh

set -eu

MODEL_FILE=/stable-diffusion/models/sd-v1-4-full-ema.ckpt

[ -f "$MODEL_FILE" ] || (
	echo Downloading model...
	wget -O ${MODEL_FILE}.tmp https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4-full-ema.ckpt &&
	mkdir -p /stable-diffusion/models/ldm/stable-diffusion-v1 &&
	ln -sf $MODEL_FILE /stable-diffusion/models/ldm/stable-diffusion-v1/model.ckpt &&
	mv ${MODEL_FILE}.tmp $MODEL_FILE
)

set -x

python /stable-diffusion/scripts/txt2img.py "$@"
