setwd("D:/EXTRA/Data Science")
# Decision Tree in R ----

library(rpart)
library(dplyr)
library(data.tree)
library(caTools)

data <- read.csv("Chennai houseing sale.csv")
df1 <- data.frame("TOTAL_PRICE" = data$SALES_PRICE+data$COMMIS+data$REG_FEE)
data2 <- cbind(data, df1)
data2$PARK_FACIL <- factor(data2$PARK_FACIL, levels = c("Yes", "No"), labels = c(1,0))
data2$AREA <- factor(data2$AREA, level = c("Karapakkam", "Adyar", "Chrompet", "Velachery", "KK Nagar", "Anna Nagar", "T Nagar"), labels = c(1,2,3,4,5,6,7))
data2$SALE_COND <- factor(data2$SALE_COND, level = c("Partial", "Family", "AbNormal", "Normal Sale", "AdjLand"), labels = c(1,2,3,4,5))
data2$STREET <- factor(data2$STREET, level = c("No Access", "Paved", "Gravel"), labels = c(1,2,3))
data2$MZZONE <- factor(data2$MZZONE, level = c("A", "C", "I", "RL", "RH", "RM"), labels = c(1,2,3,4,5,6))

set.seed(123)
row <- sample(nrow(data2))
data2 <- data2[row,]
newData <- data2[,2:23]
data3 <- na.omit(newData)
my.normalize = function(b){
  if (is.numeric(b)) {
    b = (b - min(b)) / (max(b) - min(b))
  }
  return (b)
}
data2_norm <- as.data.frame(lapply(data3,my.normalize))
newData1 <- select(data2_norm ,INT_SQFT, AREA, DIST_MAINROAD,N_BEDROOM, N_BATHROOM, N_ROOM, SALE_COND, PARK_FACIL, STREET, MZZONE,QS_ROOMS, QS_BATHROOM,QS_BEDROOM,QS_OVERALL,SALES_PRICE, TOTAL_PRICE)

set.seed(123)
sample = sample.split(newData1, SplitRatio = .80)
train = subset(newData1, sample==TRUE)
test = subset(newData1, sample==FALSE)

dTree <- rpart(TOTAL_PRICE ~ ., data = train)
pred <- predict(dTree, test)

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

RSQUARE(test$TOTAL_PRICE, pred)
MAPE(test$TOTAL_PRICE, pred)
RMSE(test$TOTAL_PRICE,pred)
