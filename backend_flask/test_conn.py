from db_config import get_connection

try:
    conn = get_connection()
    print("✅ Berhasil konek ke PostgreSQL!")
    conn.close()
except Exception as e:
    print("❌ Gagal konek:", e)
