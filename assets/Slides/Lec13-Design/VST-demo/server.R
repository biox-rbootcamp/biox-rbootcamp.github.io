library("ggplot2")
library("tibble")
library("gridExtra")
library("DESeq2")
library("airway")
library("vsn")
data("airway")

aw = estimateSizeFactors(DESeqDataSet(airway, design = ~ cell + dex))
aw = aw[ rowSums(counts(aw)) > 1, ]

vst = function(x, a, b)
  log((1 + 2*a*x + b + 2 * sqrt(a*x*(1 + a*x + b)))/(4*a)) / log(2)

function(input, output, session) {
  awt = reactive({
    vst(counts(aw), input$a, input$b)
  })

  output$plot <- renderPlot({
    grid.arrange(
      ggplot(as_tibble(awt()), aes(x = SRR1039508, y = SRR1039509)) +
        geom_hex(bins = 50) + coord_fixed(),
      meanSdPlot(awt(), plot = FALSE)$gg,
      ggplot(tibble(original    = rep(counts(aw)[, 1], 2),
                    transformed = c(awt()[, 1], log2(counts(aw)[, 1])),
                    what        = rep(c("VST", "log2"), each = nrow(aw))),
             aes(x = original, y = transformed, col = what)) + geom_line() +
        xlim(c(0, 60)) + ylim(c(-1, 6)),
      ncol = 2)
  }, height = 600, width = 700)
}