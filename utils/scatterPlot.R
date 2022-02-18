scatterPlot <- function(data, cols) {
    ggplot(data, aes_string(x = cols[1], y = cols[2])) +
        geom_point(aes(color = selected_)) +
        scale_color_manual(values = c("black", "#66D65C"), guide = FALSE)
}
