LINUX_DIR   ?=
CONFIG_PATH ?= ${PWD}/.config
OUTPUT_DIR   = /out

config-image:
	docker build \
		-t kernel-config \
		-f Dockerfile.config \
		.

config: config-image
	docker run \
		--rm -it \
		--name kernel-config \
		-v ${LINUX_DIR}:/src -w /src \
		-v ${CONFIG_PATH}:${OUTPUT_DIR}/.config \
		kernel-config \
			make O=${OUTPUT_DIR} menuconfig
