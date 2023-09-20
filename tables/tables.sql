CREATE TYPE pavilion_name as ENUM ('asia', 'europe', 'north america', 'south america', 'australia');
CREATE TYPE item_type as ENUM ('toy', 'furniture', 'treat', 'medicine');


CREATE TABLE IF NOT EXISTS items (
    id INT PRIMARY KEY,
    cost DECIMAL,
    weight DECIMAL NOT NULL,
    type item_type NOT NULL,
    expiraton_date DATE
);
CREATE TABLE IF NOT EXISTS aviary (
    id INT PRIMARY KEY,
    size decimal NOT NULL,
    pavilion pavilion_name,
    outdoors boolean NOT NULL,
    construction_date DATE NOT NULL,
    cleaning_stuff_size INT not null
);
CREATE TABLE IF NOT EXISTS animals (
    id INT PRIMARY KEY,
    aviary_id INT,
    FOREIGN KEY (aviary_id) REFERENCES aviary(id),
    species VARCHAR (20),
    weight decimal NOT NULL,
    height decimal NOT NULL,
    endangered boolean NOT NULL,
    age INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS items_to_animals (
    id INT PRIMARY KEY,
    animal_id INT,
    item_id INT,
    FOREIGN KEY (animal_id) REFERENCES animals(id),
    FOREIGN KEY (item_id) REFERENCES items(id),
    availability boolean NOT NULL
);
