CREATE TABLE IF NOT EXISTS animals (
    id INT PRIMARY KEY,
    aviary_id INT,
    FOREIGN KEY (aviary_id) REFERENCES aviary(id),
    name VARCHAR (20),
    weight decimal NOT NULL,
    height decimal NOT NULL,
    endangered boolean NOT NULL,
    age INTEGER NOT NULL
);
