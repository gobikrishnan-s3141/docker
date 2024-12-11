# Podman ( a Docker alternative with a daemon-less architecture)

## [Podman](https://docs.podman.io/en/latest/)  
  
   - run, build, share, deploy, & manage containers with ease  
   - Python, R, and a basic Linux environments for rapid development  
   - syntax is similar to Docker, so it should work with any docker without any issue (replace 'podman' with 'docker')  
   - file formats supported: OCI, SIF  
   *check out [Singularity](https://docs.sylabs.io/guides/4.2/user-guide/) for running containers in HPC environments*
   
## build a container  
```  
podman build -t .   
podman build -t pybox -f Py.dockerfile
```

**for building all images in this repo at once**
``` 
podman build -t pybox -f Py.dockerfile && podman build -t rbox -f R.dockerfile && podman build -t shbox -f sh.dockerfile && podman build -t bshbox -f bsh.dockerfile  
```  
### run podman images in interactive mode
```
podman run -it ubuntu:latest
```
Replace ubuntu:latest with other pre-built official tags found [here](https://hub.docker.com/search?badges=official)

*Never run into "It works on my machine moment"*
