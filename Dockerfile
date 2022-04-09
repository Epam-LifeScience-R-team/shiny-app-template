FROM rhub/r-minimal:4.1.3

ENV USER=docker
ENV REPOS "https://cran.rstudio.com"

# install gcc
RUN apk add build-base

USER root

RUN mkdir /.cache
RUN chmod -R 777 /.cache
RUN chmod -R 777 /usr/local/lib/R

RUN adduser $USER --disabled-password

WORKDIR /home/$USER

USER $USER

RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"