install.packages("tidyverse")
library(tidyverse)

# DATA 420 — Lab 02: Mileage Mining
# Name: Daniel Chidi
# Date: 2026-05-22

library(tidyverse)

glimpse(mpg)
?mpg

dim(mpg)

glimpse(mpg)

mean_hwy   <- mean(mpg$hwy)
median_hwy <- median(mpg$hwy)

mpg %>%
  group_by(manufacturer) %>%
  summarise(avg_hwy = round(mean(hwy), 2)) %>%
  arrange(desc(avg_hwy)) %>%
  print(n = Inf)



# Q5. 
# Filter where year == 2008

cat("Number of 2008 vehicles:", nrow(mpg_2008), "\n")


avg_cty_2008 <- mean(mpg_2008$cty)
cat("Average City MPG (2008):", round(avg_cty_2008, 2), "\n")

#Q6
compact_highmpg <- mpg %>%
  filter(hwy > 30 & class == "compact")

cat("Number of vehicles with hwy > 30 and class == compact:", nrow(compact_highmpg), "\n")

#Q7

ggplot(data = mpg, aes(x = cty, y = hwy)) +
  geom_point(color = "steelblue", alpha = 0.6, size = 2.5) +
  labs(
    title = "City MPG vs Highway MPG",
    x     = "City MPG (cty)",
    y     = "Highway MPG (hwy)"
  ) +
  theme_minimal()

#Q8
mpg %>%
  group_by(class) %>%
  summarise(
    avg_hwy      = round(mean(hwy), 2),
    avg_cty      = round(mean(cty), 2),
    num_vehicles = n()
  ) %>%
  arrange(desc(avg_hwy))

#Q9 
mpg <- mpg %>%
  mutate(efficient = hwy > 30)

# Count how many vehicles are efficient
mpg %>%
  count(efficient)


#Q10
1- Compact and subcompact vehicles have the highest average
# highway MPG, making them the most fuel-efficient classes
# in the dataset.

2-The scatter plot shows a strong positive relationship between
# city and highway MPG. Vehicles that are fuel efficient in
# the city are almost always fuel efficient on the highway too.
3- group_by() allows us to calculate summary statistics like
# average MPG for each vehicle class separately, making it
# easy to compare performance across groups in one step.
4- The mpg dataset only covers 38 popular models from 1999 to
# 2008, meaning it does not represent modern vehicles or the
# full range of manufacturers, which limits how broadly we
# can apply these findings to current fuel economy decisions.






