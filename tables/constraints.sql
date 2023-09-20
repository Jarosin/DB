ALTER TABLE items
ADD CONSTRAINT pk_items PRIMARY KEY(id);
ALTER TABLE items
ALTER COLUMN weight SET NOT NULL;
ALTER TABLE items
ALTER COLUMN type SET NOT NULL;
ALTER TABLE items
ADD CONSTRAINT price_check CHECK(cost > 0);
ALTER TABLE items
ADD CONSTRAINT weight_check CHECK(weight > 0);


ALTER TABLE aviary
ADD CONSTRAINT pk_aviary PRIMARY KEY(id);
ALTER TABLE aviary
ALTER COLUMN size SET NOT NULL;
ALTER TABLE aviary
ALTER COLUMN outdoors SET NOT NULL;
ALTER TABLE aviary
ALTER COLUMN construction_date SET NOT NULL;
ALTER TABLE aviary
ALTER COLUMN cleaning_stuff_size SET NOT NULL;
ALTER TABLE aviary
ALTER COLUMN pavilion SET NOT NULL;
ALTER TABLE aviary
ADD CONSTRAINT size_check CHECK(size > 0 AND cleaning_stuff_size > 0);

ALTER TABLE animals
ADD CONSTRAINT pk_animals PRIMARY KEY(id);
ALTER TABLE animals
ADD CONSTRAINT fk_animals FOREIGN KEY (aviary_id) REFERENCES aviary(id);
ALTER TABLE animals
ALTER COLUMN weight SET NOT NULL;
ALTER TABLE animals
ALTER COLUMN height SET NOT NULL;
ALTER TABLE animals
ALTER COLUMN endangered SET NOT NULL;
ALTER TABLE animals
ALTER COLUMN age SET NOT NULL;
ALTER TABLE animals
ADD CONSTRAINT weight_check CHECK(weight > 0);
ALTER TABLE animals
ADD CONSTRAINT height_check CHECK(height > 0);
ALTER TABLE animals
ADD CONSTRAINT age_check CHECK(age > 0);

ALTER TABLE items_to_animals
ADD CONSTRAINT pk_items_to_animals PRIMARY KEY(id);
ALTER TABLE items_to_animals
ADD CONSTRAINT fk_animal FOREIGN KEY (animal_id) REFERENCES animals(id);
ALTER TABLE items_to_animals
ADD CONSTRAINT fk_item FOREIGN KEY (item_id) REFERENCES items(id);
ALTER TABLE items_to_animals
ALTER COLUMN availability SET NOT NULL;
