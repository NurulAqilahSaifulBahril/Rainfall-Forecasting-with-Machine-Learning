# ============================================================
# SARIMA Model for Monthly Rainfall Forecasting
# Case Study: Cameron Highlands, Malaysia (2010–2019)
# ============================================================

# Libraries
library(forecast)
library(tseries)
library(zoo)
library(Metrics)
library(ggplot2)

# ------------------------------------------------------------
# 1. Load Data
# ------------------------------------------------------------
# Monthly rainfall data (mm)
data <- read.csv("data/cameron_highlands_rainfall.csv")

# Use first 108 observations as training data
train <- data[1:108, ]
y <- ts(train, frequency = 12)

# ------------------------------------------------------------
# 2. Exploratory Analysis & Stationarity Check
# ------------------------------------------------------------
# Visual inspection of trend and seasonality
ggtsdisplay(y)

# Augmented Dickey-Fuller test for stationarity
adf.test(y, k = 12)

# Box-Cox transformation check
# Lambda ≈ 1 indicates no transformation is required
BoxCox.lambda(y)

# Seasonal differencing to remove annual seasonality
y <- diff(y, lag = 12, differences = 1)
ggtsdisplay(y)
data.frame(y)
adf.test(y, k=12)

# ------------------------------------------------------------
# 3. SARIMA Model Selection
# ------------------------------------------------------------
# Compare multiple SARIMA configurations using AIC and BIC

fits1 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(0,1,0), period = 12))

AIC(fits1)
BIC(fits1)

fits2 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(0,1,1), period = 12))

AIC(fits2)
BIC(fits2)

fits3 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(1,1,0), period = 12))

AIC(fits3)
BIC(fits3)

fits4 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(1,1,1), period = 12))

AIC(fits4)
BIC(fits4)

fits5 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(2,1,0), period = 12))

AIC(fits5)
BIC(fits5)

# ------------------------------------------------------------
# 4. Model Diagnostics
# ------------------------------------------------------------
# Plot fitted values against actual data
plot(y)
lines(fitted(fits5,col="red")

# Error metrics (in-sample)
rmse(y, fitted(fits5))
mae(y, fitted(fits5))
mape(y, fitted(fits5))

# Residual independence check
Box.test(fits5$residuals, type = "Ljung")
tsdiag(fits5)

# ------------------------------------------------------------
# 5. Forecasting
# ------------------------------------------------------------
# Forecast next 9 months (out-of-sample)
forecast <- forecast(fits5, h = 9)
autoplot(forecast)
forecast
      
# ------------------------------------------------------------
# 6. Compare Forecast with Actual Values
# ------------------------------------------------------------
actual <- c(198.4083, 257.9578, 203.3523, 333.5484, 283.1853, 291.672, 257.7136, 240.4231, 179.3909))

rmse(actual, forecast)
mae(actual, forecast)
mape(actual, forecast)

actualsarima = ts(data, start=2010, frequency=12)
plot(actualsarima)
predsarima = ts(predicted2, start=2019, frequency=12)
lines(predsarima, col="blue")

