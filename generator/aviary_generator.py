from base_generator import BaseGenerator
import random

class AviaryGenerator(BaseGenerator):
    def __init__(self) -> None:
        super().__init__()
        self.names = ["wolve", "lion", "antelope", "beaver", "capybara",
                      "elephant", "squirrel", "horse", "goat", "cheetah", "zebra",
                      "fox", "goose", "hawk", "crab", "sealion",
                      "hedgehog", "mole", "duck", "baboon", "peacock",
                      "flamingo", "lynx", "owl", "wombat", "sheep", "bison",
                      "buffalo", "bull", "kangaroo", "bear", "camel", "rabbit",
                      "donkey", "deer", "tiger", "pig", "giraffe", "turtle"]

        self.pavilion_types = ('asia', 'europe', 'north america', 'south america', 'australia')

        self.size_min = 600
        self.size_max = 5000

        self.dates = [1936, 1954, 1969, 1990, 2008, 2021]

        self.stuff_per_hundred_square_meter = 0.2


    def fill_db(self, db_connection, amount_of_records):
        cursor = db_connection.cursor()
        insert_query = """INSERT INTO aviary (id, size, pavilion, is_outdoors, construction_date, cleaning_stuff_size)"""

        for i in range(amount_of_records):
            size = random.randint(self.size_min, self.size_max)
            stuff_size = size / 100 * 0.2
            record_to_insert = (random.randint(0, amount_of_records - 1),
                                size,
                                self.pavilion_types[random.randint(0, len(self.names) - 1)],
                                bool(random.random()),
                                self.dates[random.randint(0, len(self.dates) - 1)],
                                stuff_size
                                )

            cursor.execute(insert_query, record_to_insert)
        return
