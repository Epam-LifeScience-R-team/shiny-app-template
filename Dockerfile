FROM rhub/r-minimal:4.1.3

ENV REPOS "https://cran.rstudio.com"

USER root

RUN chmod -R 777 /usr/local/lib/R/

RUN addgroup -S docker && adduser -S -G docker docker 

USER docker
RUN pwd
RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"