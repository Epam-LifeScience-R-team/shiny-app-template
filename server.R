function(input, output, session) {
    df <- callModule(linkedScatter, "scatters", reactive(mpg),
        left = reactive(c("cty", "hwy")),
        right = reactive(c("drv", "hwy"))
    )

    output$summary <- renderText({
        sprintf("%d observation(s) selected", nrow(dplyr::filter(df(), selected_)))
    })
}
