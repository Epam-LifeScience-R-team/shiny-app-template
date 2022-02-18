fixedPage(
    tags$head(
        shiny::singleton(
            tags$link(rel = "stylesheet", type = "text/css", href = "css/style.css")
        ),
        shiny::singleton(
            tags$script(src = "js/shinyConnection.js")
        )
    ),
    h2("Module example"),
    linkedScatterUI("scatters"),
    textOutput("summary")
)
