# Rainfall Forecasting with Machine Learning

This project applies **time series analysis** and **machine learning techniques** to forecast **monthly rainfall** in Cameron Highlands, Malaysia.  

Two models are developed and compared:

- **Seasonal ARIMA (SARIMA)** – statistical time series model  
- **Artificial Neural Network (ANN)** – machine learning approach  

The study evaluates model performance using standard forecasting error metrics and identifies the most suitable approach for rainfall prediction.

## Objectives
- Model historical rainfall data using **SARIMA** and **ANN**
- Forecast future rainfall values
- Compare statistical and machine learning approaches for time series forecasting

## Scope of Study
- **Location:** Cameron Highlands, Peninsular Malaysia  
- **Data Period:** January 2010 – December 2019  
- **Frequency:** Monthly rainfall (mm)  
- **Forecast Horizon:** 2020  

Malaysia’s tropical climate and monsoon seasons introduce strong seasonality, making this a suitable case study for seasonal time series modeling.

## Dataset
- **Source:** Provided by lecturer (academic dataset)
- **Observations:** 120 monthly records
- **Target Variable:** Rainfall (mm)

### Data Split
| Dataset | Period | Observations |
|------|------|------|
| Training (In-sample) | Jan 2010 – Dec 2018 | 108 |
| Testing (Out-sample) | Jan 2019 – Sep 2019 | 9 |

## Tools & Technologies
- **Language:** R  
- **Libraries:**  
  - `forecast`, `tseries`, `zoo`, `Metrics`  
  - `neuralnet`, `nnfor`, `monmlp`, `ggplot2`

## Exploratory Data Analysis
**Descriptive Statistics (Cameron Highlands Rainfall):**

| Metric | Value |
|------|------|
| Mean | 223.25 |
| Median | 210.60 |
| Min | 18 |
| Max | 516 |
| Variance | 115.03 |
| Skewness | -0.70 |
| Kurtosis | 2.25 |

The data exhibits **seasonality and non-stationarity**, consistent with monsoon-driven rainfall patterns.

## Model 1: SARIMA

### Model Selection
Multiple SARIMA configurations were evaluated using **AIC** and **BIC**.

**Selected Model:**  
**SARIMA (0,0,0) × (2,1,1)₁₂**

### Training Performance
- RMSE: **0.4666**
- MAE: **0.3425**
- MAPE: **0.0043**

### Diagnostic Checking
- **Ljung–Box test p-value:** 0.4336  
- Residuals are independently distributed

### Forecasting Performance
- RMSE: **0.4648**
- MAE: **0.4092**
- MAPE: **0.0073**

The SARIMA model captures seasonal patterns but shows slightly higher forecast error.

## Model 2: Artificial Neural Network (ANN)

### Model Architecture
- Lag inputs: **15**
- Hidden neurons tested: **6–11**
- Best model: **ANN (15, 9, 1)**

### Training Performance
- RMSE: **0.5905**
- MAE: **0.3367**
- MAPE: **0.0022**

### Residual Diagnostics
- **R²:** 0.869  
- **Ljung–Box p-value:** 0.3511  
- Residuals show no autocorrelation

### Out-of-Sample Forecasting Performance
- RMSE: **0.3821**
- MAE: **0.3137**
- MAPE: **0.0052**

The ANN model demonstrates improved forecasting accuracy compared to SARIMA.

## Model Comparison

| Model | RMSE | MAE | MAPE |
|------|------|------|------|
| SARIMA | 0.4648 | 0.4092 | 0.0073 |
| ANN | **0.3821** | **0.3137** | **0.0052** |

**Final Selected Model: **Artificial Neural Network (ANN)**

## Conclusion
Both SARIMA and ANN successfully modeled seasonal rainfall patterns. However, the **ANN model outperformed SARIMA** in forecasting accuracy, making it the preferred approach for rainfall prediction in Cameron Highlands.

This project demonstrates:
- Time series preprocessing and stationarity analysis
- Comparison of statistical and machine learning models
- Model evaluation using industry-standard error metrics

## Future Improvements
- Implement advanced deep learning models such as **LSTM** or **GRU**
- Incorporate **exogenous variables** (e.g., temperature, humidity, ENSO index)
- Deploy the forecasting model as a **decision-support system** for agriculture and risk management



