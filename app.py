"""
Приложение для работы с материалами и поставщиками
Демонстрационный экзамен — Python
"""
from flask import Flask, render_template, request, redirect, url_for, session
import psycopg2
import psycopg2.extras

app = Flask(__name__)
app.secret_key = 'materials_exam_2026'

def get_db():
    return psycopg2.connect(dbname="materials_db", user="postgres", host="/var/run/postgresql", port="5433")

@app.route('/')
def index():
    return render_template('login.html', error=None)

@app.route('/login', methods=['POST'])
def login():
    login = request.form.get('login')
    password = request.form.get('password')
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    cur.execute("SELECT * FROM users WHERE login = %s AND password = %s", (login, password))
    user = cur.fetchone()
    cur.close()
    conn.close()
    if user:
        session['user'] = dict(user)
        return redirect(url_for('materials_list'))
    return render_template('login.html', error="Неверный логин или пароль")

@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect(url_for('index'))

@app.route('/materials')
@app.route('/materials/<int:page>')
def materials_list(page=1):
    per_page = 6
    search = request.args.get('search', '')
    sort = request.args.get('sort', '')
    conn = get_db()
    cur = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
    query = """SELECT m.*, mt.name as type_name FROM materials m 
               LEFT JOIN material_types mt ON m.material_type_id = mt.id WHERE 1=1"""
    params = []
    if search:
        query += " AND m.name ILIKE %s"
        params.append(f'%{search}%')
    if sort == 'price_asc': query += " ORDER BY m.price ASC"
    elif sort == 'price_desc': query += " ORDER BY m.price DESC"
    else: query += " ORDER BY m.name"
    cur.execute(f"SELECT COUNT(*) FROM ({query}) AS sub", params)
    total = cur.fetchone()[0]
    total_pages = max(1, (total + per_page - 1) // per_page)
    if page < 1: page = 1
    if page > total_pages: page = total_pages
    query += f" LIMIT {per_page} OFFSET {(page-1)*per_page}"
    cur.execute(query, params)
    materials = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('materials.html', materials=materials, page=page, total_pages=total_pages, search=search, sort=sort)

if __name__ == '__main__':
    app.run(debug=True, port=5000)
