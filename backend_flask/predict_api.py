from flask import Flask, request, jsonify
import numpy as np
from tensorflow.keras.models import load_model
from sklearn.preprocessing import MinMaxScaler
import datetime

app = Flask(__name__)

# Muat model
model = load_model("models/menstruation_lstm_model.h5")

# Skaler dummy (karena skaler saat training tidak disimpan)
scaler = MinMaxScaler()

@app.route("/predict", methods=["POST"])
def predict_next_period():
    try:
        data = request.get_json()

        panjang_siklus = float(data["panjang_siklus"])
        frekuensi_stres = int(data["frekuensi_stres"])
        lama_menstruasi = float(data["lama_menstruasi"])
        last_period_date = data["tanggal_terakhir_menstruasi"]  # format: YYYY-MM-DD

        input_data = np.array([[panjang_siklus, frekuensi_stres, lama_menstruasi]])
        input_scaled = scaler.fit_transform(input_data)
        input_scaled = input_scaled.reshape((1, 1, 3))

        predicted_days = model.predict(input_scaled)[0][0]

        last_date = datetime.datetime.strptime(last_period_date, "%Y-%m-%d")
        predicted_date = last_date + datetime.timedelta(days=round(predicted_days))

        return jsonify({
            "predicted_date": predicted_date.strftime("%Y-%m-%d"),
            "message": "Prediksi berhasil!"
        })

    except Exception as e:
        return jsonify({
            "error": str(e),
            "message": "Gagal melakukan prediksi"
        }), 500

if __name__ == "__main__":
    app.run(debug=True)
