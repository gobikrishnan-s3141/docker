# Podman ( a Docker alternative with a daemon-less architecture)
## [Podman](https://docs.podman.io/en/latest/)
   - run, build, share, deploy, & manage containers with ease     
   - Python, R, and a basic Linux environments for rapid development     
   - syntax is similar to Docker, so it should work with any docker without any issue (replace 'podman' with 'docker') 
   - file formats supported: OCI, SIF
   - The images used in this repo are mostly `ubuntu-LTS`, which is more reliable and has more up-to-date packages than `debian`.
   *check out [Singularity](https://docs.sylabs.io/guides/4.2/user-guide/) for running containers in HPC environments*

### Docker file structure
- FROM --> pulls a pre-built image <base_image> from docker.io/quay.io
- ENV --> set environment variables
- WORKDIR --> set working directory (usually root directory)
-  USER --> create a user with lesser privileges for better security
-  COPY --> copy files into the container
- EXPOSE --> expose specific ports to be exposed (port : 8080)
- VOLUME --> manage volumes for containers
- RUN --> run commands
- ENTRYPOINT --> set entrypoint
- CMD --> set default command to run when container starts

### build a container
```shell     
podman build -t .      
podman build -t pybox -f Py.dockerfile  
```  
### for building all images in this repo at once
```shell    
podman build -t pybox -f Py.dockerfile && podman build -t rbox -f R.dockerfile && podman build -t shbox -f sh.dockerfile && podman build -t bshbox -f bsh.dockerfile     
``` 
### run podman images in interactive mode
```shell  
podman run -it ubuntu:latest  
```  
Replace `ubuntu:latest` with other pre-built official tags found [here](https://hub.docker.com/search?badges=official)  
  
*Never run into "It works on my machine!" moment*
