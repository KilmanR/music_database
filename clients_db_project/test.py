import psycopg2

# Подключение к базе данных
def connect_to_db():
    conn = psycopg2.connect(
        host="localhost",
        database="music_database",
        user="your_username",
        password="your_password"
    )
    cursor = conn.cursor()
    return conn, cursor

# Создание таблицы
def create_db_tables(conn, cursor):
    cursor.execute('''
        CREATE TABLE IF NOT EXISTS clients (
            id SERIAL PRIMARY KEY,
            first_name VARCHAR(100) NOT NULL,
            last_name VARCHAR(100) NOT NULL,
            email VARCHAR(255) UNIQUE NOT NULL,
            phones TEXT
        )
    ''')
    conn.commit()

# Добавление нового клиента
def add_customer(conn, cursor, first_name, last_name, email):
    cursor.execute('''
        INSERT INTO clients (first_name, last_name, email) VALUES (%s, %s, %s)
    ''', (first_name, last_name, email))
    conn.commit()
    
# Добавление телефона для существующего клиента
def add_phone(conn, cursor, customer_id, phone):
    cursor.execute('''
        UPDATE clients SET phones = CASE WHEN phones IS NULL THEN %s ELSE phones || ', ' || %s END WHERE id = %s
    ''', (phone, phone, customer_id))
    conn.commit()

# Изменение данных о клиенте
def update_customer(conn, cursor, customer_id, first_name=None, last_name=None, email=None):
    if first_name:
        cursor.execute('''
            UPDATE clients SET first_name = %s WHERE id = %s
        ''', (first_name, customer_id))
    
    if last_name:
        cursor.execute('''
            UPDATE clients SET last_name = %s WHERE id = %s
        ''', (last_name, customer_id))
    
    if email:
        cursor.execute('''
            UPDATE clients SET email = %s WHERE id = %s
        ''', (email, customer_id))
    
    conn.commit()

# Удаление телефона для существующего клиента
def delete_phone(conn, cursor, customer_id, phone):
    cursor.execute('''
        UPDATE clients SET phones = CASE WHEN phones IS NULL THEN '' ELSE REPLACE(phones, '%s,', '') END WHERE id = %s
    ''', (phone, customer_id))
    conn.commit()

# Удаление существующего клиента
def delete_customer(conn, cursor, customer_id):
    cursor.execute('DELETE FROM clients WHERE id = %s', (customer_id,))
    conn.commit()

# Поиск клиента по имени, фамилии, email или телефону
def find_customer(conn, cursor, first_name=None, last_name=None, email=None, phone=None):
    query = 'SELECT * FROM clients'
    
    if first_name:
        query += f' WHERE first_name LIKE %s'
        
    if last_name:
        if first_name is not None:
            query += ' AND '
        query += f'last_name LIKE %s'
    
    if email:
        if first_name or last_name:
            query += ' AND '
        query += f'email LIKE %s'
    
    if phone:
        if first_name or last_name or email:
            query += ' AND '
        query += f'phones LIKE %s'
    
    cursor.execute(query, (f'%{first_name}%', f'%{last_name}%', f'%{email}%', f'%{phone}%'))
    return cursor.fetchall()

# Закрытие соединения с базой данных
def close_db(conn):
    conn.close()