import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression
from sklearn.pipeline import make_pipeline

# Data Generation
np.random.seed(42)
def true_function(x):
    return np.sin(1.5 * np.pi * x)

noise_std = 0.20
X_train = np.random.uniform(-1, 1, 80).reshape(-1, 1)
y_train = true_function(X_train.ravel()) + np.random.normal(0, noise_std, 80)

X_val = np.linspace(-1, 1, 300).reshape(-1, 1)
y_val = true_function(X_val.ravel()) + np.random.normal(0, noise_std, 300)