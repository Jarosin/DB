from base_generator import BaseGenerator
import random
from faker import Faker

class AviaryGenerator(BaseGenerator):
    def __init__(self) -> None:
        super().__init__()
        self.cost_min = 0.2
        self.cost_max = 1500

        self.weight_min = 0.1
        self.weight_max = 500

        self.item_types = ["toy", "furniture", "treat", "medicine"]

        latest_date = "+10y"
        earliest_date = "-3y"

    def fill_db(self, db_connection, amount_of_records):
        cursor = db_connection.cursor()
        insert_query = """INSERT INTO items (id, cost, weight, type, expiration_date) VALUES (%s, %s, %s, %s, %s)"""

        fake = Faker()
        for i in range(amount_of_records):
            date = fake.date_time_between(start_date = self.earliest_date, end_date = self.latest_date)
            date = date.strftime("%d/%m/%Y")
            record_to_insert = (random.randint(0, amount_of_records - 1),
                                random.uniform(self.cost_min, self.cost_max),
                                random.uniform(self.weight_min, self.weight_max),
                                self.item_types[random.randint(0, len(self.item_types) - 1)],
                                date
                                )

            cursor.execute(insert_query, record_to_insert)
        return
