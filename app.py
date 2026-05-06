"""
Приложение "Сладкий рай" на Flask
Демонстрационный экзамен — Python
"""
import os
from flask import Flask, render_template, request, redirect, url_for, session
import psycopg2
import psycopg2.extras
import bcrypt

app = Flask(__name__)
app.secret_key = 'sweet_paradise_secret_2026'

# Подключение к базе данных
def get_db():
    conn = psycopg2.connect(
        dbname="sweet_paradise",
        user="postgres",
        host="/var/run/postgresql",
        port="5433"
    )
    return conn

# Главная страница — вход
@app.route('/')
def index():
    return render_template('login.html', error=None)

# Авторизация
@app.route('/login', methods=['POST'])
def login():
    login = request.form.get('login')
    password = request.form.get('password')
    try:
        conn = get_db()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        cur.execute("SELECT * FROM users WHERE login = %s", (login,))
        user = cur.fetchone()
        cur.close()
        conn.close()
        if user and bcrypt.checkpw(password.encode(), user['password'].encode()):  # В реальном проекте — через bcrypt
            session['user'] = dict(user)
            return redirect(url_for('cakes_list'))
        return render_template('login.html', error="Неверный логин или пароль")
    except Exception as e:
        return render_template('login.html', error=f"Ошибка: {e}")

# Выход
@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect(url_for('index'))

# Каталог тортов с пагинацией
@app.route('/cakes')
@app.route('/cakes/<int:page>')
def cakes_list(page=1):
    per_page = 6  # Количество товаров на странице
    search = request.args.get('search', '')
    sort = request.args.get('sort', '')
    try:
        conn = get_db()
        cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
        
        # Базовый запрос
        query = """
            SELECT c.*, cat.name as category_name, ct.name as type_name, 
                   conf.name as confectionery_name
            FROM cakes c
            LEFT JOIN categories cat ON c.category_id = cat.id
            LEFT JOIN cake_types ct ON c.cake_type_id = ct.id
            LEFT JOIN confectioneries conf ON c.confectionery_id = conf.id
            WHERE 1=1
        """
        params = []
        
        # Поиск
        if search:
            query += " AND (c.name ILIKE %s OR c.description ILIKE %s)"
            params.extend([f'%{search}%', f'%{search}%'])
        
        # Сортировка
        if sort == 'price_asc':
            query += " ORDER BY c.price ASC"
        elif sort == 'price_desc':
            query += " ORDER BY c.price DESC"
        else:
            query += " ORDER BY c.name"
        
        # Считаем общее количество записей
        count_query = f"SELECT COUNT(*) FROM ({query}) AS sub"
        cur.execute(count_query, params)
        total = cur.fetchone()[0]
        total_pages = max(1, (total + per_page - 1) // per_page)
        
        # Проверка номера страницы
        if page < 1:
            page = 1
        if page > total_pages:
            page = total_pages
        
        offset = (page - 1) * per_page
        
        # Выполняем запрос с пагинацией
        query += f" LIMIT {per_page} OFFSET {offset}"
        cur.execute(query, params)
        cakes = cur.fetchall()
        cur.close()
        conn.close()
        
        return render_template('cakes.html', 
                             cakes=cakes, 
                             page=page, 
                             total_pages=total_pages,
                             search=search, 
                             sort=sort)
    except Exception as e:
        return f"Ошибка загрузки каталога: {e}"

# Действия админа: CRUD для тортов
@app.route('/admin/add', methods=['GET', 'POST'])
def admin_add():
    if not session.get('user') or session['user']['role_id'] != 4:
        return redirect(url_for('cakes_list'))
    
    if request.method == 'POST':
        try:
            conn = get_db()
            cur = conn.cursor()
            cur.execute("""
                INSERT INTO cakes (name, category_id, cake_type_id, description, 
                                  confectionery_id, supplier_id, price, quantity_in_stock, discount)
                VALUES (%s, %s, %s, %s, %s, 2, %s, %s, %s)
            """, (
                request.form['name'],
                request.form['category_id'],
                request.form['cake_type_id'],
                request.form['description'],
                request.form['confectionery_id'],
                float(request.form['price']),
                int(request.form['quantity_in_stock']),
                float(request.form.get('discount', 0))
            ))
            conn.commit()
            cur.close()
            conn.close()
            return redirect(url_for('cakes_list'))
        except Exception as e:
            return f"Ошибка сохранения: {e}"
    
    # GET-запрос — показываем форму
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT * FROM categories")
    categories = cur.fetchall()
    cur.execute("SELECT * FROM cake_types")
    types = cur.fetchall()
    cur.execute("SELECT * FROM confectioneries")
    confs = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('admin_form.html', cake=None, 
                         categories=categories, types=types, confs=confs)

# Удаление торта
@app.route('/admin/delete/<int:cake_id>')
def admin_delete(cake_id):
    if not session.get('user') or session['user']['role_id'] != 4:
        return redirect(url_for('cakes_list'))
    try:
        conn = get_db()
        cur = conn.cursor()
        cur.execute("DELETE FROM cakes WHERE id = %s", (cake_id,))
        conn.commit()
        cur.close()
        conn.close()
    except Exception as e:
        pass
    return redirect(url_for('cakes_list'))

if __name__ == '__main__':
    app.run(debug=True, port=5000)
