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
y_diff <- diff(y, lag = 12)
ggtsdisplay(y_diff)

# ------------------------------------------------------------
# 3. SARIMA Model Selection
# ------------------------------------------------------------
# Compare multiple SARIMA configurations using AIC and BIC

fit_0010 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(0,1,0), period = 12))

fit_0011 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(0,1,1), period = 12))

fit_0110 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(1,1,0), period = 12))

fit_0111 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(1,1,1), period = 12))

fit_0210 <- Arima(y, order = c(0,0,0),
                  seasonal = list(order = c(2,1,0), period = 12))

fit_final <- Arima(y, order = c(0,0,0),
                   seasonal = list(order = c(2,1,1), period = 12))

AIC(fit_final)
BIC(fit_final)

# ------------------------------------------------------------
# 4. Model Diagnostics
# ------------------------------------------------------------
# Plot fitted values against actual data
autoplot(y) +
  autolayer(fitted(fit_final), series = "Fitted", color = "red")

# Error metrics (in-sample)
rmse(y, fitted(fit_final))
mae(y, fitted(fit_final))
mape(y, fitted(fit_final))

# Residual independence check
Box.test(fit_final$residuals, type = "Ljung")
tsdiag(fit_final)

# ------------------------------------------------------------
# 5. Forecasting
# ------------------------------------------------------------
# Forecast next 9 months (out-of-sample)
forecast_sarima <- forecast(fit_final, h = 9)
autoplot(forecast_sarima)

# ------------------------------------------------------------
# 6. Compare Forecast with Actual Values
# ------------------------------------------------------------
actual <- c(107.8, 19.4, 111.2, 181.0, 273.8, 155.8, 125.6, 154.4, 111.2)

rmse(actual, forecast_sarima$mean)
mae(actual, forecast_sarima$mean)
mape(actual, forecast_sarima$mean)
