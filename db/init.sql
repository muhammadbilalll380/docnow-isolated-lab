CREATE TABLE IF NOT EXISTS documents (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT
);
INSERT INTO documents (title, body) VALUES
  ('Sample document 1', 'Mock data for the lab'),
  ('Sample document 2', 'Fake content, no real data');
