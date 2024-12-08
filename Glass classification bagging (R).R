

# Packages
library(baguette)
library (mlbench)
library(tidymodels)

tidymodels_prefer ()

# Load and preview dataset 
data(Glass)
glimpse (Glass)


# Set seed for reproducibility and perform training and test split. 
set.seed(96)
split <- initial_split(Glass, prop = 0.8)
train <- training(split)
test <- testing(split)

# Bagging 
bagModel <- bag_tree(
  mode = "classification",
  set_engine("rpart")
)

# Create a recipe with the formula
recipeBag <- recipe(Species ~ ., data = train)

# Setup model wf
wf <- workflow() %>%  add_model(bag_spec) %>% add_recipe(iris_recipe)

# Fit and predict
iris_bag_fit <- fit(iris_workflow, data = iris_train)

iris_preds <- predict(iris_bag_fit, new_data = iris_test) %>% bind_cols(iris_test)

iris_preds %>% metrics(truth = Species, estimate = .pred_class)








