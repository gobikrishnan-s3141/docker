# Podman ( a Docker alternative with a daemon-less architecture)

## [Podman](https://docs.podman.io/en/latest/)  
  
   - run, build, share, deploy, & manage containers with ease  
   - Python, R, and a basic Linux environments for rapid development  
   - syntax is similar to Docker, so it should work with any docker without any issue (replace 'podman' with 'docker')  
   - file formats supported: OCI, SIF  
   * check out Singularity for running containers in HPC environments"  
  
## build a container  
```  
podman build -t .   
podman build -t pybox -f Py.dockerfile
```

**for building all images in this repo at once**
``` 
podman build -t pybox -f Py.dockerfile && podman build -t rbox -f R.dockerfile && podman build -t shbox -f sh.dockerfile && podman build -t bshbox -f bsh.dockerfile  
```  
  
**Feel free to download and the template**
