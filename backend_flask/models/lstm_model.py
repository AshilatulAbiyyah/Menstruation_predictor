import pandas as pd
import numpy as np
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import MinMaxScaler
import os

# Load dataset
df = pd.read_excel("data/data_responden_359.xlsx")

# Preview kolom (ganti sesuai dataset kamu)
print("Kolom:", df.columns)
print(df.head())
