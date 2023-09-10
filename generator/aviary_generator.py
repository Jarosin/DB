from .base_generator import BaseGenerator
import random
from faker import Faker

class AviaryGenerator(BaseGenerator):
    def __init__(self) -> None:
        super().__init__()
        self.pavilion_types = ('asia', 'europe', 'north america', 'south america', 'australia')

        self.size_min = 600
        self.size_max = 5000

        self.stuff_per_hundred_square_meter = 0.2

        self.earliest_date = "-70y"
        self.latest_date = "today"

    def fill_db(self, db_connection, amount_of_records):
        cursor = db_connection.cursor()
        insert_query = """INSERT INTO aviary (id, size, pavilion, outdoors, construction_date, cleaning_stuff_size) VALUES (%s, %s, %s, %s, %s, %s)"""

        fake = Faker()
        for i in range(amount_of_records):
            date = fake.date_between(start_date = self.earliest_date, end_date = self.latest_date)
            date = date.strftime("%d/%m/%Y")
            size = random.randint(self.size_min, self.size_max)
            stuff_size = size / 100 * 0.2
            record_to_insert = (i,
                                size,
                                self.pavilion_types[random.randint(0, len(self.pavilion_types) - 1)],
                                bool(random.randint(0, 1)),
                                date,
                                int(stuff_size) + 1
                                )

            cursor.execute(insert_query, record_to_insert)
            db_connection.commit()
        return
