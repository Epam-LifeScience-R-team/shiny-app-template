FROM rhub/r-minimal:4.1.3

ENV REPOS "https://cran.rstudio.com"

USER root
RUN adduser docker --disabled-password
RUN chmod -R 777 /usr/local/lib/R/

USER docker
RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"