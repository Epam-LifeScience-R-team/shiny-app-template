FROM r-hub/r-minimal:4.1.3

ENV REPOS "https://cran.rstudio.com"

USER docker
RUN R -e "install.packages('renv', repos=Sys.getenv('REPOS'))"