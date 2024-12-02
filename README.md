# Podman ( a Docker alternative with a daemon-less architecture )

## Podman
alternative to the mighty docker - you can use docker to avoid better deployment for larger scale
- build, deploy & manage containers with ease
- Python & R environments for quick development
- synatx is similar to Docker, so it should work with any docker without any issue

### build a container
    podman build -t . 
    podman build -f Py.dockerfile
    
* use official images for most cases for better functionality and support
* debian base for Python and R; ubuntu for latest software; alpine for minimal & secure env

*Feel free to download and use the template*
