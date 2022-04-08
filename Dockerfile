FROM rhub/r-minimal:4.1.3

ENV REPOS "https://cran.rstudio.com"
ENV USER=docker

USER root

RUN chmod -R 777 /usr/local/lib/R/library

RUN adduser $USER --disabled-password

WORKDIR /home/$USER

USER $USER

RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"