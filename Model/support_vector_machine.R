setwd("E:/ds/ds_labWork")
library(e1071)
library(dplyr)

data <- read.csv("Chennai houseing sale.csv")
df1 <- data.frame("TOTAL_PRICE" = data$SALES_PRICE+data$COMMIS+data$REG_FEE)
data2 <- cbind(data, df1)
dataClean <- na.omit(data2)
newData1 <- select(dataClean ,INT_SQFT, AREA, DIST_MAINROAD,N_BEDROOM, N_BATHROOM, N_ROOM, SALE_COND, PARK_FACIL, BUILDTYPE,UTILITY_AVAIL, STREET, MZZONE,QS_ROOMS, QS_BATHROOM,QS_BEDROOM,QS_OVERALL,SALES_PRICE, TOTAL_PRICE)
categorical <- c("SALE_COND", "BUILDTYPE", "MZZONE", "STREET", "UTILITY_AVAIL", "AREA", "PARK_FACIL")
newData1[categorical] <- lapply(newData1[categorical], factor)

set.seed(123)
regressor <- svm(formula = TOTAL_PRICE ~ . , data = newData1, type = 'eps-regression', kernel = 'radial')
pred <- predict(regressor, newData1)
pred

RSQUARE = function(y_actual,y_predict){
  cor(y_actual,y_predict)^2
}

MAPE = function(y_actual,y_predict){
  mean(abs((y_actual-y_predict)/y_actual))*100
}

RMSE <- function(y_actual, y_predict) {
  residuals <- y_actual - y_predict
  sqrt(mean(residuals^2,na.rm=TRUE))
}

RSQUARE(newData1$TOTAL_PRICE,pred)
MAPE(newData1$TOTAL_PRICE,pred)
RMSE(newData1$TOTAL_PRICE, pred)