CREATE TABLE IF NOT EXISTS schedules (
    id           INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    title        VARCHAR(255),
    date         INTEGER
);

CREATE TABLE IF NOT EXISTS accounts (
    id           INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    content      VARCHAR(255),
    date         INTEGER,
    money        INTEGER,
    category     INTEGER
);
