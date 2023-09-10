CREATE TYPE item_type as ENUM("toy", "furniture", "treat", "medicine");

CREATE TABLE IF NOT EXISTS items (
    id INT PRIMARY KEY,
    cost DECIMAL,
    WEIGHT DECIMAL NOT NULL,
    type item_type NOT NULL,
    expritation_date DATETIME
);
