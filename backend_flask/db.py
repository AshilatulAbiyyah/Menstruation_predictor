import psycopg2

def get_connection():
    return psycopg2.connect(
        dbname="db_period",
        user="postgres",
        password="",       # <- isi password PostgreSQL kamu kalau ada
        host="localhost",
        port="5432"
    )
    cursor = conn.cursor()