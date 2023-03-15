library(tidyverse)

points <- tibble(
  age = c(38, 45, 52, 61, 80, 74), 
  prop = c(0.146, 0.241, 0.571, 0.745, 0.843, 0.738))

colors <- list(
  data = "#41414550",
  fit = "#414145")

ggplot(points) + 
  aes(x = age, y = prop) + 
  geom_point(size = 3.5, color = colors$data) +
  scale_x_continuous(
    name = "Age in months", 
    limits = c(0, 96), 
    # Because age is in months, I want breaks to land on multiples
    # of 12. The `Q` in `extended_breaks()` are "nice" numbers to use
    # for axis breaks.
    breaks = scales::extended_breaks(Q = c(24, 12))) + 
  scale_y_continuous(
    name = "Intelligibility",
    limits = c(0, NA),
    labels = scales::percent_format(accuracy = 1))

xs <- seq(0, 96, length.out = 80)

# Create the curve from the equation parameters
trend <- tibble(
  age = xs,
  asymptote = .8,
  scale = .2,
  midpoint = 48,
  prop = asymptote / (1 + exp((midpoint - age) * scale)))

ggplot(points) + 
  aes(x = age, y = prop) + 
  geom_line(data = trend, color = colors$fit) +
  geom_point(size = 3.5, color = colors$data) +
  scale_x_continuous(
    name = "Age in months", 
    limits = c(0, 96), 
    breaks = scales::extended_breaks(Q = c(24, 12))) + 
  scale_y_continuous(
    name = "Intelligibility",
    limits = c(0, NA),
    labels = scales::percent_format(accuracy = 1))
