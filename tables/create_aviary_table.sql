DROP TYPE IF EXISTS pavilion_name CASCADE;
CREATE TYPE pavilion_name as ENUM ('asia', 'europe', 'north america', 'south america', 'australia');

CREATE TABLE IF NOT EXISTS aviary (
    id INT PRIMARY KEY,
    size decimal NOT NULL,
    pavilion pavilion_name,
    outdoors boolean NOT NULL,
    construction_date DATE NOT NULL,
    cleaning_stuff_size INT not null
);
