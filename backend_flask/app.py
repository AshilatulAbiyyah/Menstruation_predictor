from flask import Flask, request, jsonify
from flask_cors import CORS
from models.user_model import find_user_by_email, check_password, register_user
from models.menstruation_model import save_menstruation_data  # ✅ harus di atas

app = Flask(__name__)
CORS(app)

# ✅ Default route
@app.route('/')
def index():
    return 'Hello from Flask!'

# ✅ Route login
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({"message": "Email dan password wajib diisi"}), 400

    user = find_user_by_email(email)
    if not user:
        return jsonify({"message": "Email tidak ditemukan"}), 404

    stored_password = user[3]  # kolom ke-4 = password
    if check_password(stored_password, password):
        return jsonify({
            "message": "Login berhasil",
            "user_id": user[0],
            "email": user[2],
            "name": user[1]
        }), 200
    else:
        return jsonify({"message": "Password salah"}), 401

# ✅ Route register
@app.route('/register', methods=['POST'])
def register():
    data = request.get_json()
    name = data.get('name')
    email = data.get('email')
    password = data.get('password')

    if not all([name, email, password]):
        return jsonify({"message": "Semua field wajib diisi"}), 400

    existing = find_user_by_email(email)
    if existing:
        return jsonify({"message": "Email sudah terdaftar"}), 400

    register_user(email, password, name)
    return jsonify({"message": "Registrasi berhasil!"}), 200

# ✅ Route input data menstruasi
@app.route('/input-menstruasi', methods=['POST'])
def input_menstruasi():
    data = request.get_json()
    user_id = data.get('user_id')
    start_date = data.get('start_date')
    cycle_length = data.get('cycle_length')
    duration = data.get('duration')

    if not all([user_id, start_date, cycle_length, duration]):
        return jsonify({"message": "Semua data wajib diisi"}), 400

    save_menstruation_data(user_id, start_date, cycle_length, duration)

    return jsonify({"message": "Data menstruasi berhasil disimpan"}), 200

# ✅ Harus di paling bawah
if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)
