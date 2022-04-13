FROM rhub/r-minimal:4.1.3

ENV USER=docker
ENV REPOS "https://cran.rstudio.com"

RUN apk add gcc musl-dev g++ && \
    # additional gcc packages for 'Matrix' package on R
    apk add gfortran libquadmath && \
    # additional package for 'ps' package on R
    apk add linux-headers && \
    # additional package for 'curl' package on R
    apk add curl-dev && \
    # additional dependencies for 'httpuv' package on R
    apk add \
    --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/v3.11/main \
      autoconf=2.69-r2 \
      automake=1.16.1-r0 && \
    apk add zlib-dev && \
    # additional dependencies for 'xml2' package on R
    apk add libxml2-dev

USER root

RUN mkdir /.cache
RUN chmod -R 777 /.cache
RUN chmod -R 777 /usr/local/lib/R

RUN adduser $USER --disabled-password

WORKDIR /home/$USER

USER $USER

RUN R -e "install.packages('renv', repos=Sys.getenv('REPOS'))"