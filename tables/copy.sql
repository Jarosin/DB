COPY animals(id, aviary_id, species, weight, height, endangered, age)
FROM '../csv_files/animals.csv'
DELIMITER ','
CSV HEADER;


COPY animals(id, size, pavilion, outdoors, construction_date, cleaning_stuff_size)
FROM '../csv_files/aviaries.csv'
DELIMITER ','
CSV HEADER;

COPY items(id, cost, weight, type, expiraton_date)
FROM '../csv_files/items.csv'
DELIMITER ','
CSV HEADER;


COPY items_to_animals(id, animal_id, item_id, availability)
FROM '../csv_files/items_to_animals.csv'
DELIMITER ','
CSV HEADER;
