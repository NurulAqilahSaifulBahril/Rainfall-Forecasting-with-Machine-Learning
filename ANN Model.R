# ============================================================
# ANN Model for Monthly Rainfall Forecasting
# Case Study: Cameron Highlands, Malaysia (2010–2019)
# ============================================================

# Libraries
library(nnfor)       # For mlp
library(forecast)    # For accuracy and forecast plotting
library(ggplot2)

# ------------------------------------------------------------
# 1. Load Data
# ------------------------------------------------------------
data <- read.csv("data/cameron_highlands_rainfall.csv")

# Use first 108 months as training
train = data[1:108, ]

# Convert to time series
ts_data <- ts(train, frequency=12)

# ------------------------------------------------------------
# 2. Train ANN models with different hidden nodes
# ------------------------------------------------------------
ann1<-mlp(tstrain,m=15,hd=1,reps=200)
print(ann1)

ann2<-mlp(tstrain,m=15,hd=2,reps=200)
print(ann2)

ann3<-mlp(tstrain,m=15,hd=3,reps=200)
print(ann3)

ann4<-mlp(tstrain,m=15,hd=4,reps=200)
print(ann4)

ann5<-mlp(tstrain,m=15,hd=5,reps=200)
print(ann5)

ann6<-mlp(tstrain,m=15,hd=6,reps=200)
print(ann6)

ann7<-mlp(tstrain,m=15,hd=7,reps=200)
print(ann7)

ann8<-mlp(tstrain,m=15,hd=8,reps=200)
print(ann8)

ann9<-mlp(tstrain,m=15,hd=9,reps=200)
print(ann9)

ann10<-mlp(tstrain,m=15,hd=10,reps=200)
print(ann10)

ann11<-mlp(tstrain,m=15,hd=11,reps=200)
print(ann11)

plot(ann9)

plot(tstrain)
lines(fitted(ann9),col="red")

mae(tstrain,fitted(ann9))
mape(tstrain,fitted(ann9))
rmse(tstrain,fitted(ann9))

# ------------------------------------------------------------
# 3. Forecast using best ANN
# ------------------------------------------------------------
foreann9<-forecast(ann9,h=9,include=20)
plot(foreann9)
summary(foreann9)
foreann9

# ------------------------------------------------------------
# 4. Plot actual vs fitted vs forecast
# ------------------------------------------------------------
Actual=c(107.800, 19.400, 111.200, 181.000, 273.801, 155.800, 125.600, 154.400,
111.200)
Predicted= c(166.3589, 179.3460, 190.3890, 328.2511, 278.0159, 119.4208,
116.0486, 265.0447, 276.3458)

mae(Actual,Predicted)
mape(Actual,Predicted)
mrmse(Actual,Predicted)

actualann9 = ts(data,start=2010, frequency =12)
plot(actualann9)
predann9 = ts(Predicted,start=2019, frequency =12)
lines(predann9,col="blue")
lines(predsarima,col="red")

