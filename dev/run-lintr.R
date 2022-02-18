
excludedDirs <- c("www", "inst", "packrat", "renv")
excludedFiles <- unlist(
    purrr::map(
        file.path(getwd(), excludedDirs),
        list.files,
        recursive = TRUE,
        pattern = rex::rex(".", one_of("Rr"), end),
        full.names = TRUE
    )
)

result <- lintr::lint_dir(
    path = getwd(),
    linters = lintr::with_defaults(
        line_length_linter = lintr::line_length_linter(150),
        # CamelCase for R6 classes
        object_name_linter = lintr::object_name_linter(styles = c("camelCase", "CamelCase")),
        object_length_linter = lintr::object_length_linter(45),
        # disable due to poor working with R6 classes
        cyclocomp_linter = NULL,
        # disable to avoid conflicts with styler
        open_curly_linter = NULL,
        object_usage_linter = NULL
    ),
    exclusions = setNames(as.list(rep(Inf, length(excludedFiles))), excludedFiles)
)


if (length(result) > 0) {
    print(result)
}
