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

### For Windows users

Make sure that you use Git Bash tool as default Terminal interpreter. If it is not, specify the path to Git Bash in your IDE, for example `C:\Program Files\Git\bin\bash.exe` 

Set PATH environment variables for R.exe and RScript.exe
* Go to Control Panel
* Search "Edit environment variables" for your account
* Under User variables select Path
* Click Edit
* Select New
* Paste the path to the _folder that contains_ the `R.exe` and `RScript.exe` files, for example `C:\Program Files\R\R-4.1.3\bin`
* Click OK
* You will need to close and re-open your command-line for the PATH changes to take effect

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
