"""Mock DocNow API - a tiny stand-in service for the isolated lab."""
import os
import psycopg2
from flask import Flask, jsonify, request

app = Flask(__name__)


def conn():
    return psycopg2.connect(
        host=os.environ["DB_HOST"], user=os.environ["DB_USER"],
        password=os.environ["DB_PASSWORD"], dbname=os.environ["DB_NAME"],
    )


@app.get("/health")
def health():
    return jsonify(status="ok")


@app.get("/documents")
def list_docs():
    with conn() as c, c.cursor() as cur:
        cur.execute("SELECT id, title, body FROM documents ORDER BY id")
        rows = [{"id": r[0], "title": r[1], "body": r[2]} for r in cur.fetchall()]
    return jsonify(rows)


@app.post("/documents")
def add_doc():
    data = request.get_json(force=True)
    with conn() as c, c.cursor() as cur:
        cur.execute(
            "INSERT INTO documents (title, body) VALUES (%s, %s) RETURNING id",
            (data.get("title", "untitled"), data.get("body", "")),
        )
        new_id = cur.fetchone()[0]
    return jsonify(id=new_id), 201
