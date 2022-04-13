#' Performs various substitutions in files in a directory (by default only .R files are styled - see filetype argument)
#' Carefully examine the results after running this function!
changedFiles <- styler::style_dir(
    ".",
    indent_by = 4,
    exclude_dirs = c("packrat", "packages", "www", "inst", "renv")
)

if (any(changedFiles$changed)) {
    stop("Some files have been changed! Please review the changes and commit again.")
}
