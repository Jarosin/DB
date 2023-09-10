CREATE TABLE IF NOT EXISTS items_to_animals (
    id INT PRIMARY KEY,
    animal_id INT,
    item_id INT,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (item_id) REFERENCES items(id),
    is_given_out boolean NOT NULL
);
