# Shiny App Template

## Project structure

- `config/` - config files. You may use `config` package to work with the configuration.
- `dev/` - any scripts to setup your environment.
- `modules/` - shiny modules.
- `renv/` - used by tracking dependencies by `renv` package.
- `tests/` - tests
    - `testthat/` - tests using the `testthat` package
    - `shinytest/` - tests using the `shinytest` package
    - `<...>/` - any other tests
- `utils/` - R scripts for your shiny app
- `www/` 
    - `js` - javascript files
    - `css` - css files

## Getting Started

### Restore packages

```{r}
renv::restore()
```

See more [here](https://rstudio.github.io/renv/articles/renv.html)

### Add environment variables

Create **.Renviron** file in the project directory and put there any secret values that are used by your app.

```{r}
PASSWORD1=***
PASSWORD2=***
```

### Run tests

```{r}
shiny::runTests()
```

### Run lintr

```{r}
source("dev/run-lintr.R")
```