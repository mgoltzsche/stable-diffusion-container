FROM continuumio/miniconda3:4.9.2-alpine

RUN apk add --update --no-cache git bash
RUN set -eux; \
	git clone https://github.com/CompVis/stable-diffusion.git /stable-diffusion; \
	cd /stable-diffusion; \
	git checkout 21f890f9da3cfbeaba8e2ac3c425ee9e998d5229
WORKDIR /stable-diffusion
RUN conda env create -f environment.yaml
SHELL ["conda", "run", "-n", "ldm", "/bin/bash", "-c"]
RUN pip install diffusers==0.12.1
RUN apk add --update --no-cache git bash glib libsm libxrender libxext

# Add model to image?!
#ENV MODEL_FILE=/stable-diffusion/models/sd-v1-4-full-ema.ckpt
#RUN wget -O $MODEL_FILE https://huggingface.co/CompVis/stable-diffusion-v-1-4-original/resolve/main/sd-v1-4-full-ema.ckpt
#RUN ln -sf $MODEL_FILE /stable-diffusion/models/ldm/stable-diffusion-v1/model.ckpt
#RUN conda run --no-capture-output -n ldm /stable-diffusion.sh || true

COPY stable-diffusion.sh /
ENTRYPOINT [ "conda", "run", "--no-capture-output", "-n", "ldm", "/stable-diffusion.sh" ]
