import bcrypt

# Ganti dengan password yang kamu inginkan
password = "rahasia123"

# Proses hash
hashed = bcrypt.hashpw(password.encode(), bcrypt.gensalt())

# Tampilkan hasil hash
print("Password asli:", password)
print("Password hashed:", hashed.decode())
