

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
modelBag <- bag_tree(
  mode = "classification",
  engine = "rpart"
)

# Create a recipe with the formula
recipeBag <- recipe(Type ~ ., data = train)

# Setup model wf
wf <- workflow() %>%  add_model(modelBag) %>% add_recipe(recipeBag)

# Fit and predict
fitted <- fit(wf, data = train)
predicted <- predict(fitted, new_data = test) %>% bind_cols(test)

# Assess
predicted %>% metrics(truth = Type, estimate = .pred_class)








