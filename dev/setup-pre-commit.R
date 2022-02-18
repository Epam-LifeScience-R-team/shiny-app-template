# setup pre-commit hook
if (interactive()) {
    local({
        gitHooksDir <- ".git/hooks"
        preCommitFile <- file.path(gitHooksDir, "pre-commit")
        if (dir.exists(gitHooksDir) && !file.exists(preCommitFile)) {
            file.link("dev/pre-commit.R", preCommitFile)
            message("Pre-commit hook has been setup.")
        }
    })
}
