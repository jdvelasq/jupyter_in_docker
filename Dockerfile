#
# Se instala desde una imagen de Ubuntu para facilitar la instalación
# de herramientas alternas
#
FROM ubuntu:20.04

ENV LANG C.UTF-8 

WORKDIR /app
COPY . /app

ENV DEBIAN_FRONTEND noninteractive

# -- utils  -----------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
    wget \
    curl \
    git-all \
    make \
    zip \
    unzip \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# -- python3  ---------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
    python3-pip \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*


# -- nodejs -----------------------------------------------------------------------------
RUN apt-get update \
    && apt-get install -y ca-certificates xz-utils \
    && curl -O https://nodejs.org/dist/v16.4.0/node-v16.4.0-linux-x64.tar.xz \
    && tar -xf node-v16.4.0-linux-x64.tar.xz \
    && cp -r node-v16.4.0-linux-x64/* /usr/ \
    && ln -s "$(which node)" /usr/bin/nodejs \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# -- pip upgrade ------------------------------------------------------------------------
RUN pip3 install --upgrade pip

# -- draw.io ----------------------------------------------------------------------------
RUN pip3 install --trusted-host pypi.python.org  --default-timeout=100 \    
    jupyterlab-drawio


# -- Jupyter Lab ------------------------------------------------------------------------
RUN pip install --trusted-host pypi.python.org --default-timeout=100 \
    jupyterlab==3.2.9 \
    && mkdir /root/.jupyter \
    && mv jupyter_notebook_config.py /root/.jupyter/ \
    && mkdir /root/.jupyter/lab \
    && mkdir /root/.jupyter/lab/user-settings \
    && mkdir /root/.jupyter/lab/user-settings/@jupyterlab \
    && mkdir /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension \
    && mv tracker.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/

# -- Code Formater ----------------------------------------------------------------------
RUN pip install --trusted-host pypi.python.org --default-timeout=100 \
    jupyterlab_code_formatter \
    black \
    isort \
    && mkdir /root/.jupyter/lab/user-settings/@ryantam626 \
    && mkdir /root/.jupyter/lab/user-settings/@ryantam626/jupyterlab_code_formatter \
    && mv settings_jupyterlab-settings /root/.jupyter/lab/user-settings/@ryantam626/jupyterlab_code_formatter/settings.jupyterlab-settings



# -- Parte generica ---------------------------------------------------------------------
EXPOSE  8888
ENV DEBIAN_FRONTEND=dialog
RUN rm -rf /app/*
WORKDIR /workspace
SHELL ["/bin/bash", "-c"]
ENTRYPOINT jupyter lab




