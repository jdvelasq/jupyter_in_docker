# jupyter_in_docker
Demo de creación de un contenedor de trabajo con Jupyter Las


**Creación del contendor**

```bash
$ docker build --tag=jdvelasq/jupyterlab:3.2.9 .
```

**Subida del contenedor a Docker Hub**

```bash
$ docker push jdvelasq/jupyterlab:3.2.9
```

**Corrida del contenedor en la carpeta actual**

```bash 
$ docker run --rm -it -v "$PWD":/workspace --name jupyterlab -p 8888:8888 jdvelasq/jupyterlab:3.2.9
```

**Apertura de una consola alterna**

```bash
$ docker exec -it jupyterlab bash
```

