CREATE TABLE IF NOT EXISTS animals-items (
    id INT PRIMARY KEY,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (item_id) REFERENCES items(id),
    is_given_out boolean NOT NULL
);
