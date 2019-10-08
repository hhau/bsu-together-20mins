library(ggplot2)
library(wsre)
library(tibble)

blues <- c(
  light = "#A6E9FF",
  mid = "#2C7FB8",
  dark = "#00214F"
) 

highlight_col <- wesanderson::wes_palette("FantasticFox1")[5]

plot_df <- data.frame(
  x = seq(from = -4, to = 6, length.out = 5000)
)

n_points <- 150
x_sims <- rnorm(n_points)
a_bw <- bw.SJ(x_sims) / 1.65

kde_func <- function(x) {
  wsre:::kde_func_nd(x, as.matrix(x_sims), a_bw)
}

text_tbl <- tibble(
  x = c(0),
  y = c(0.4),
  label = c(
    "hat('p')[2](phi)"#,
    # "'p'['meld, 1'](phi~'|'~'Y'[1])"
    # "'w'[italic('w')](phi~';'~xi[italic('w')])"
  )
)

phi_star <- 3.2
phi <- -1.5

point_tbl <- tibble(
  x = c(phi, phi_star),
  y = rep(0, 2),
  label = c(
    "phi",
    "phi^{'*'}"
  )
)

true_ratio <- dnorm(phi) / dnorm(phi_star)
est_ratio <- kde_func(phi) / kde_func(phi_star)

ratio_tbl <- tibble(
  x = c(4, 4),
  y = c(0.2, 0.3),
  label = c(
    "hat('r')(phi['nu'],~phi['de']) = '~22,201,000'",
    "'r'(phi['nu'],~phi['de']) = '~54'"
  )
)

p1 <- ggplot(plot_df, aes(x = x)) +
  geom_area(
    stat = "function",
    fun = function(X) sapply(X, kde_func),
    fill = highlight_col,
    alpha = 0.95
  ) +
  geom_text(
    inherit.aes = FALSE,
    data = text_tbl,
    mapping = aes(x = x, y = y, label = label),
    parse = TRUE,
    col = c(highlight_col),
    size = 5.5
  ) +
  geom_point(
    inherit.aes = FALSE,
    data = point_tbl,
    mapping = aes(x = x, y = y),
    size = 1.5
  ) +
  geom_text(
    inherit.aes = FALSE,
    data = point_tbl,
    mapping = aes(x = x, y = y + 0.03, label = label),
    parse = TRUE,
    size = 8.5
  ) +
  geom_text(
    inherit.aes = FALSE,
    data = ratio_tbl,
    mapping = aes(x = x, y = y + 0.03, label = label),
    parse = TRUE,
    size = 4.5
  ) +
  theme_classic() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.line.y = element_blank()
  ) +
  xlab(expression(phi))

p1
