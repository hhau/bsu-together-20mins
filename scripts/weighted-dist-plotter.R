library(ggplot2)

blues <- c(
  light = "#A6E9FF",
  mid = "#2C7FB8",
  dark = "#00214F"
) 

highlight_col <- wesanderson::wes_palette("FantasticFox1")[5]

plot_df <- data.frame(
  x = seq(from = -3, to = 13, length.out = 5000)
)

p_p <- function(x) {
  dnorm(x, mean = 0)
}

p_w <- function(x) {
  dnorm(x, mean = 10)
} 

q_s <- function(x) {
  p_p(x) * p_w(x) 
}

nc <- integrate(q_s, lower = -15, upper = 20)
p_s <- function(x) {
  q_s(x) / nc$value
}

text_df <- data.frame(
  x = c(0, 5, 10),
  y = c(0.075, 0.075, 0.075),
  label = c(
    "'p'(phi)",
    "'s'(phi)",
    "'w'(phi~';'~xi)"
  )
)


p1 <- ggplot(plot_df, aes(x = x)) +
  geom_area(
    stat = "function", fun = p_p, fill = blues["dark"]
  ) +
  geom_area(
    stat = "function", fun = p_w, fill = blues["light"]
  ) +
  geom_area(
    stat = "function", fun = p_s, fill = blues["mid"]
  ) +
  # stat_function(
  #   fun = p_s, col = highlight_col, xlim = c(2, 8), size = 1
  # ) +
  theme_classic() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.line.y = element_blank()
  ) +
  geom_text(
    inherit.aes = FALSE,
    data = text_df,
    mapping = aes(x = x, y = y, label = label),
    parse = TRUE,
    col = "white",
    size = 4.5
  ) +
  xlab(expression(phi))

# p1

ggsave(
  file = "figures/weighted-dist-plot.pdf",
  plot = p1,
  width = 5, 
  height = 3.25
)

# Many W's

plot_df_many <- data.frame(
  x = seq(from = -3, to = 16, length.out = 5000)
)

text_df_many <- data.frame(
  x = c(0, 5, 10),
  y = c(0.075, 0.075, 0.075),
  label = c(
    "'p'(phi)",
    "'s'[italic('w')](phi)",
    "'w'[italic('w')](phi~';'~xi[italic('w')])"
  )
)

p_w_many_1 <- function(x) {
  dnorm(x, mean = 12)
} 

q_s_many_1 <- function(x) {
  p_p(x) * p_w_many_1(x) 
}

nc_many_1 <- integrate(q_s_many_1, lower = -15, upper = 20)
p_s_many_1 <- function(x) {
  q_s_many_1(x) / nc_many_1$value
}

p_w_many_2 <- function(x) {
  dnorm(x, mean = 14)
} 

q_s_many_2 <- function(x) {
  p_p(x) * p_w_many_2(x) 
}

nc_many_2 <- integrate(q_s_many_2, lower = -15, upper = 20)
p_s_many_2 <- function(x) {
  q_s_many_2(x) / nc_many_2$value
}

p_many <- ggplot(plot_df_many, aes(x = x)) +
  geom_area(
    stat = "function", fun = p_p, fill = blues["dark"]
  ) +
  geom_area(
    stat = "function", fun = p_w, fill = blues["light"]
  ) +
  geom_area(
    stat = "function", fun = p_s, fill = blues["mid"]
  ) +
  geom_area(
    stat = "function", fun = p_w_many_1, fill = blues["light"], alpha = 0.6
  ) +
  geom_area(
    stat = "function", fun = p_s_many_1, fill = blues["mid"], alpha = 0.6
  ) +
  geom_area(
    stat = "function", fun = p_w_many_2, fill = blues["light"], alpha = 0.4
  ) +
  geom_area(
    stat = "function", fun = p_s_many_2, fill = blues["mid"], alpha = 0.4
  ) +
  theme_classic() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.line.y = element_blank()
  ) +
  geom_text(
    inherit.aes = FALSE,
    data = text_df_many,
    mapping = aes(x = x, y = y, label = label),
    parse = TRUE,
    col = "white",
    size = 4  
  ) +
  xlab(expression(phi)) +
  NULL

p_many

ggsave(
  file = "figures/weighted-dist-plot-many.pdf",
  plot = p_many,
  width = 5, 
  height = 3.25
)