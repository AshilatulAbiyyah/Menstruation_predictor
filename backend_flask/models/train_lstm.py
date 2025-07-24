import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import train_test_split
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import LSTM, Dense
import matplotlib.pyplot as plt
import os

# ✅ Load data
df = pd.read_excel("data_responden_359.xlsx")

# ✅ Ambil kolom yang dipakai
df = df[['Tanggal Terakhir Menstruasi', 'Panjang Siklus', 'Pola Menstruasi', 'Frekuensi Stress', 'Lama Menstruasi']]

# ✅ Konversi data string ke angka
df['Panjang Siklus'] = df['Panjang Siklus'].astype(str).str.extract(r'(\d+)').astype(float)
df['Lama Menstruasi'] = df['Lama Menstruasi'].astype(str).str.extract(r'(\d+)').astype(float)
df['Pola Menstruasi'] = df['Pola Menstruasi'].astype('category').cat.codes
df['Frekuensi Stress'] = df['Frekuensi Stress'].astype('category').cat.codes

# ✅ Konversi tanggal
df['Tanggal Terakhir Menstruasi'] = pd.to_datetime(df['Tanggal Terakhir Menstruasi'], errors='coerce')
df = df.dropna(subset=['Tanggal Terakhir Menstruasi'])
df = df.sort_values(by='Tanggal Terakhir Menstruasi')

# ✅ Target: selisih hari ke tanggal berikutnya
df['Next Date'] = df['Tanggal Terakhir Menstruasi'].shift(-1)
df['Target Days'] = (df['Next Date'] - df['Tanggal Terakhir Menstruasi']).dt.days
df = df.dropna(subset=['Target Days'])

# ✅ Fitur dan target
X = df[['Panjang Siklus', 'Frekuensi Stress', 'Lama Menstruasi']]
y = df['Target Days']

# ✅ Normalisasi
scaler = MinMaxScaler()
X_scaled = scaler.fit_transform(X)

# ✅ Split data
X_train, X_test, y_train, y_test = train_test_split(X_scaled, y, test_size=0.2, random_state=42)

# ✅ Bentuk untuk LSTM: (samples, timesteps, features)
X_train = X_train.reshape((X_train.shape[0], 1, X_train.shape[1]))
X_test = X_test.reshape((X_test.shape[0], 1, X_test.shape[1]))

# ✅ Buat model
model = Sequential()
model.add(LSTM(64, input_shape=(X_train.shape[1], X_train.shape[2])))
model.add(Dense(1))
model.compile(loss='mean_squared_error', optimizer='adam')

# ✅ Latih model
history = model.fit(X_train, y_train, epochs=50, batch_size=8, validation_data=(X_test, y_test), verbose=1)

# ✅ Simpan model dan grafik
os.makedirs("models", exist_ok=True)
model.save("models/menstruation_lstm_model.h5")
print(" Model berhasil dilatih dan disimpan!")

#  Plot grafik loss
plt.plot(history.history['loss'], label='Train Loss')
plt.plot(history.history['val_loss'], label='Val Loss')
plt.legend()
plt.title("Train vs Validation Loss")
plt.xlabel("Epoch")
plt.ylabel("Loss")
plt.savefig("models/loss_plot.png")
plt.close()
