from db_config import get_connection
import bcrypt

def find_user_by_email(email):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
    user = cursor.fetchone()
    conn.close()
    return user

def check_password(stored_password, provided_password):
    return bcrypt.checkpw(provided_password.encode('utf-8'), stored_password.encode('utf-8'))

from .db import cursor, conn

# ✅ Cari user berdasarkan email
def find_user_by_email(email):
    cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
    return cursor.fetchone()

# ✅ Verifikasi password (sementara tanpa hashing)
def check_password(stored_password, provided_password):
    return stored_password == provided_password

# ✅ Fungsi untuk registrasi user baru
def register_user(email, password, name):
    cursor.execute(
        "INSERT INTO users (name, email, password) VALUES (%s, %s, %s)",
        (name, email, password)
    )
    conn.commit()
