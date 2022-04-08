FROM rhub/r-minimal:4.1.3

ENV REPOS "https://cran.rstudio.com"

RUN adduser docker --disabled-password

USER docker

RUN R --vanilla -e "install.packages('renv', repos=Sys.getenv('REPOS'))"