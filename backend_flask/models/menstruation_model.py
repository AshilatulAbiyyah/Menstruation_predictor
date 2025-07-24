from db import get_connection  

def save_menstruation_data(user_id, start_date, cycle_length, duration):
    conn = get_connection()
    cur = conn.cursor()
    cur.execute("""
        INSERT INTO menstruation_data (user_id, start_date, cycle_length, duration)
        VALUES (%s, %s, %s, %s)
    """, (user_id, start_date, cycle_length, duration))
    conn.commit()
    cur.close()
    conn.close()