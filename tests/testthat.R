library(testthat)

message("Running unit tests...")
test_dir(
    "./testthat",
    env = shiny::loadSupport(),
    reporter = c("progress", "summary", "fail")
)

message("Running shinytests...")
testthat::test_dir(
    "./shinytest/",
    env = shiny::loadSupport(),
    reporter = c("progress", "summary", "fail")
)
