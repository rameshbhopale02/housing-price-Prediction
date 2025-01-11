# Housing Price Prediction in Chennai City

## Table of Contents
1. [Overview](#overview)
2. [Dataset](#dataset)
3. [Objective](#objective)
4. [Project Description](#project-description)
5. [Implementation](#implementation)
6. [Results](#Results)
7. [Conclusion](#conclusion)


---

## Overview
This project aims to predict the total house price in Chennai city using machine learning models. By analyzing housing data, it provides insights for buyers and sellers to make informed decisions.

---

## Dataset
**Name:** Chennai Housing Sale  
**Source:** [Kaggle - Chennai House Price Prediction](https://www.kaggle.com/code/kunwarakash/chennai-house-price-prediction)  

---

## Objective
To develop a predictive model for estimating house prices in Chennai city based on various features of the properties.

---

## Project Description
Real estate transactions can often lack transparency, making it challenging for buyers and sellers to determine the fair market value of a property. This project leverages data from Chennai housing sales to address this challenge by building a predictive model for house prices.  
### Key Goals:
- Help buyers identify realistic asking prices for homes.
- Assist sellers in understanding features that influence higher property values.

This project explores various factors influencing house prices, employs data cleaning and feature engineering, and uses multiple machine learning models to maximize prediction accuracy.

---

## Implementation
The project employs multiple machine learning techniques to analyze and predict housing prices. Below are the steps involved, including example pseudocode for the implemented models:

### 1. **Data Preprocessing**
- Handle missing values using `na.omit`.
- Encode categorical variables using label encoding and one-hot encoding.
- Normalize numerical data using a min-max scaler.

```r
my.normalize = function(b){
  if (is.numeric(b)) {
    b = (b - min(b)) / (max(b) - min(b))
  }
  return (b)
}

```
### 2. **Model Implementation**
1)  Random Forest
```r
library(randomForest)

rf <- randomForest(TOTAL_PRICE ~ ., data = training, mtry=7, importance=TRUE, ntree=501)
pred_train <- predict(rf, testing)

RSQUARE(testing$TOTAL_PRICE, pred_train)
MAPE(testing$TOTAL_PRICE, pred_train)
RMSE(testing$TOTAL_PRICE, pred_train)

```
2) Desion Tree
```r
library(rpart)

dTree <- rpart(TOTAL_PRICE ~ ., data = train)
pred <- predict(dTree, test)

RSQUARE(test$TOTAL_PRICE, pred)
MAPE(test$TOTAL_PRICE, pred)
RMSE(test$TOTAL_PRICE, pred)

```
4) Support Vector Machine (SVM)
```r
library(e1071)

regressor <- svm(formula = TOTAL_PRICE ~ ., data = newData1, type = 'eps-regression', kernel = 'radial')
pred <- predict(regressor, newData1)

RSQUARE(newData1$TOTAL_PRICE, pred)
MAPE(newData1$TOTAL_PRICE, pred)
RMSE(newData1$TOTAL_PRICE, pred)

```
## Results

### 1. Performance Metrics
The model's performance was evaluated using the following metrics:

| Metric           | Random Forest |Decision Tree  |  SVR    |
|------------------|---------------|---------------|---------|
| **R² Score**     | 0.9989        | 0.9725        | 0.9978  |
| **RMSE**         | 0.0056        | 0.0281        | 0.2332  |
| **MAPE**         | 1.3712        | 8.0277        | 1.5062  |

Add an image showcasing the metrics or a summary plot for better understanding:

![Performance Metrics](path/to/metrics_image.png)

---

### 2. Scatter Plot: Predicted vs Actual Prices
The scatter plot below shows the relationship between the actual and predicted prices for the test dataset. This visualizes the effectiveness of the model.

![Scatter Plot](path/to/scatter_plot.png)

---

### 3. Feature Importance
The Random Forest model provides a feature importance plot that shows which features contribute the most to predicting house prices.

![Feature Importance](path/to/feature_importance.png)

---

### 4. Residual Analysis
Residual analysis helps identify patterns in prediction errors. The plot below displays residuals for the predicted values.

![Residual Plot](path/to/residual_plot.png)

---

### 5. Model Comparisons
A comparison of R², RMSE, and MAPE values across models (Random Forest, Decision Tree, and SVR) is visualized below.

![Model Comparisons](path/to/model_comparison_plot.png)

## Conclusion
This project highlights the importance of comprehensive data preprocessing and the exploration of various machine learning models to predict housing prices accurately. Key takeaways include:
  -  Proper encoding of categorical features improves model performance.
  -  Normalization and data cleaning are crucial for reliable results.
  -  Random Forest delivered the highest R² score of 99.87%, making it the most effective model for this dataset.

