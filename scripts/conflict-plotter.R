library(ggplot2)

blues <- c(
  light = "#A6E9FF",
  mid = "#2C7FB8",
  dark = "#00214F"
) 

highlight_col <- wesanderson::wes_palette("FantasticFox1")[5]

plot_df <- data.frame(
  x = seq(from = -4, to = 14, length.out = 5000)
)

n_points <- 150
x_sims <- rnorm(n_points)
a_bw <- bw.SJ(x_sims) / 1.75

kde_func <- function(x) {
  wsre:::kde_func_nd(x, as.matrix(x_sims), a_bw)
}

stage_one_func <- function(x) {
  dnorm(x, mean = 2.5, sd = 3)
}

text_df <- data.frame(
  x = c(2.2, 9),
  y = c(0.25, 0.1),
  label = c(
    "hat('p')(phi)",
    "'p'['meld, 1'](phi~'|'~'Y'[1])"
    # "'w'[italic('w')](phi~';'~xi[italic('w')])"
  )
)

p1 <- ggplot(plot_df, aes(x = x)) +
  geom_area(
    stat = "function",
    fun = function(X) sapply(X, stage_one_func),
    fill = blues['mid'],
    alpha = 0.9
  ) +
  geom_area(
    stat = "function",
    fun = function(X) sapply(X, kde_func),
    fill = blues['dark'],
    alpha = 0.95
  ) +
  geom_text(
    inherit.aes = FALSE,
    data = text_df,
    mapping = aes(x = x, y = y, label = label),
    parse = TRUE,
    col = c(blues['dark'], blues['mid']),
    size = 5.5
  ) +
  theme_classic() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.line.y = element_blank()
  ) +
  xlab(expression(phi))

ggsave(
  file = "figures/conflict.pdf",
  plot = p1,
  width = 5, 
  height = 3.25
)
