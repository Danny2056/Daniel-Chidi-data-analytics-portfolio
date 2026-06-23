# ============================================================
# K-Means Clustering: Online Shoppers Purchasing Intention
# ============================================================

library(tidyverse)

# ---------- PART A: Load and Explore ----------

# A1: Load dataset directly from CSV link
url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00468/online_shoppers_intention.csv"
shoppers <- read.csv(url)

# A2: First six rows
head(shoppers)

# A3: Number of rows and columns
dim(shoppers)

# A4: Column names
names(shoppers)

# A5: Structure
str(shoppers)

# A6: Missing values
colSums(is.na(shoppers))


# ---------- PART B: Select Columns for Clustering ----------

# B2: Revenue is the outcome (whether a purchase happened). This is
#     unsupervised learning with no target, so Revenue is excluded —
#     including it would leak the answer we are trying to discover.

# B3: New data frame with only numeric browsing-behaviour columns
cluster_data <- shoppers %>%
  select(
    Administrative,
    Administrative_Duration,
    Informational,
    Informational_Duration,
    ProductRelated,
    ProductRelated_Duration,
    BounceRates,
    ExitRates,
    PageValues,
    SpecialDay
  )

head(cluster_data)


# ---------- PART C: Normalize the Data ----------

# C1: Scaling matters because K-Means uses distance. Columns like
#     ProductRelated_Duration span thousands while BounceRates is near 0;
#     without scaling the large columns dominate the distance calculation.

# C2: Standardize with scale()
scaled_data <- scale(cluster_data)

# C3: Confirm scaling worked (means ~0, sd ~1)
summary(scaled_data)
round(colMeans(scaled_data), 4)
round(apply(scaled_data, 2, sd), 4)


# ---------- PART D: Choose the Number of Clusters ----------

# D1 + D2: Elbow method for K = 1 to 10
set.seed(123)
wss <- numeric(10)
for (k in 1:10) {
  km <- kmeans(scaled_data, centers = k, nstart = 25)
  wss[k] <- km$tot.withinss
}
wss

plot(
  1:10,
  wss,
  type = "b",
  pch = 19,
  xlab = "Number of Clusters (K)",
  ylab = "Total Within-Cluster Sum of Squares",
  main = "Elbow Method for Choosing K"
)



# ---------- PART E: Run K-Means Clustering ----------

# E1: Random seed
set.seed(123)

# E2: Run K-Means with chosen K (using 4 — adjust to your elbow)
final_k <- 4
km_final <- kmeans(scaled_data, centers = final_k, nstart = 25)

# E3: Add cluster label back to the original dataset
shoppers$Cluster <- factor(km_final$cluster)

# E4: Count sessions per cluster
table(shoppers$Cluster)


# ---------- PART F: Visualization ----------

# F1 + F2: Scatterplot coloured by cluster
ggplot(shoppers, aes(
  x = ProductRelated_Duration,
  y = PageValues,
  colour = Cluster
)) +
  geom_point(alpha = 0.6) +
  labs(
    title = "Online Shopper Segments",
    x = "Product-Related Duration",
    y = "Page Values",
    colour = "Cluster"
  ) +
  theme_minimal()