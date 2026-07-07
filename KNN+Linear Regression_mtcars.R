install.packages("FNN")
library(tidyverse)
library(FNN)

data("mtcars")

head(mtcars)

car_data <- mtcars %>%
  rownames_to_column("car_name") %>%
  select(car_name,mpg, disp, hp, wt, qsec, am)


glimpse(car_data)
head(car_data)
summary(car_data)


set.seed(123)

sample_index <- sample(
  1:nrow(car_data),
  size = 0.7 * nrow(car_data)
)

train_data <- car_data[sample_index, ]
test_data <- car_data[-sample_index, ]


sample_car <- tibble(
  car_name = "Mazda RX4",
  disp = 160,
  hp = 110,
  wt = 2.620,
  qsec = 16.46,
  am = 1
)

actual_car_name <- "Mazda RX4"
actual_mpg <- 21.0


input_var <- c("disp", "hp", "wt", "qsec", "am")

train_x <- train_data %>%
  select(all_of(input_var))

test_x <- sample_car %>%
  select(all_of(input_var))

train_y <- train_data$mpg

train_x_scaled <- scale(train_x)

test_x_scaled <- scale(
  test_x,
  center = attr(train_x_scaled, "scaled:center"),
  scale = attr(train_x_scaled, "scaled:scale")
)


knn_model <- knn.reg(
  train = train_x_scaled,
  test = test_x_scaled,
  y = train_y,
  k = 5
)

knn_prediction <- knn_model$pred

knn_prediction



mlr_model <- lm(
  mpg ~ disp + hp + wt + qsec + am,
   data = train_data
)

summary(mlr_model)

sample_car_2 <- tibble(
  disp = 160,
  hp = 110,
  wt = 2.620,
  qsec = 16.46,
  am = 1
)

mlr_prediction <- predict(mlr_model, newdata = sample_car_2)

mlr_prediction


  


