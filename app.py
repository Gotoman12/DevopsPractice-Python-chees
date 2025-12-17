
from flask import Flask, render_template_string, request
import sqlite3

app = Flask(__name__)
DB_NAME = 'chess.db'

def init_db():
    conn = sqlite3.connect(DB_NAME)
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS moves (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    move TEXT
                )''')
    conn.commit()
    conn.close()

@app.route('/', methods=['GET', 'POST'])
def index():
    conn = sqlite3.connect(DB_NAME)
    c = conn.cursor()

    if request.method == 'POST':
        move = request.form.get('move')
        if move:
            c.execute("INSERT INTO moves (move) VALUES (?)", (move,))
            conn.commit()

    c.execute("SELECT move FROM moves")
    moves = c.fetchall()
    conn.close()

    return render_template_string('''
    <html>
    <head>
        <title>Chess Web App</title>
        <style>
            body { font-family: Arial; text-align: center; }
            table { margin: auto; border-collapse: collapse; }
            td { width: 50px; height: 50px; border: 1px solid #333; }
        </style>
    </head>
    <body>
        <h1>Chess Web Application</h1>
        <form method="post">
            <input type="text" name="move" placeholder="Enter move (e.g. e2e4)" required />
            <button type="submit">Submit Move</button>
        </form>
        <h3>Move History</h3>
        <ul>
        {% for m in moves %}
            <li>{{ m[0] }}</li>
        {% endfor %}
        </ul>
    </body>
    </html>
    ''', moves=moves)

if __name__ == '__main__':
    init_db()
    app.run(host='0.0.0.0', port=5000, debug=True)
