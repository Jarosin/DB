from .base_generator import BaseGenerator
import random

class ItemsToAnimalsGenerator(BaseGenerator):
    def __init__(self) -> None:
        super().__init__()

    def fill_db(self, db_connection, amount_of_records):
        cursor = db_connection.cursor()
        insert_query = """INSERT INTO items_to_animals (id, animal_id, item_id, is_given_out) VALUES (%s,%s,%s,%s)"""

        for i in range(amount_of_records):
            record_to_insert = (random.randint(0, amount_of_records - 1),
                                random.randint(0, amount_of_records - 1),
                                random.randint(0, amount_of_records - 1),
                                bool(random.random()))

            cursor.execute(insert_query, record_to_insert)
        return
