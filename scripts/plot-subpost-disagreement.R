library(dplyr)
source("scripts/common/plot-settings.R")

p_df <- data.frame(
  x = seq(from = -5, to = 11, length.out = 2)
)

p1 <- ggplot(p_df, aes(x = x)) +
  stat_function(fun = dnorm, aes(col = "p1"), n = 501) +
  stat_function(fun = dnorm, args = list(mean = 6), aes(col = "p2"), n = 501) +
  stat_function(fun = dnorm, args = list(mean = 3, sd = 0.5), aes(col = "pmeld"), n = 501) +
  scale_colour_manual(
    labels = parsed_map(c(
      "p1" = "'p'[1](phi~'|'~'Y'[1])",
      "p2" = "'p'[2](phi~'|'~'Y'[2])",
      "pmeld" = "'p'['meld'](phi~'|'~'Y'[2],'Y'[1])"
    )),
    values = c(
      "p1" = blues[2],
      "p2" = blues[1],
      "pmeld" = highlight_col
    )
  ) +
  scale_linetype_manual( # this does nothing
    values = c(
      "p1" = "solid",
      "p2" = "solid",
      "pmeld" = "solid"
    )
  ) +
  labs(col = "Density") +
  ylab("") + 
  xlab(expression(phi)) +
  theme_classic() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.line.y = element_blank(),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  ) +
  NULL

ggsave(
  filename = "figures/subpost-disagreement.pdf",
  plot = p1,
  width = 5, 
  height = 2.25
)