from .base_generator import BaseGenerator
import random
from faker import Faker


class AviaryGenerator(BaseGenerator):
    def __init__(self) -> None:
        super().__init__()

        self.table_name = "aviary"

        self.params = ['id', 'size', 'type', 'outdoors', 'construction_date', 'stuff_size']

        self.pavilion_types = (
            'asia', 'europe', 'north america', 'south america', 'australia')

        self.size_min = 600
        self.size_max = 5000

        self.stuff_per_hundred_square_meter = 0.2

        self.earliest_date = "-70y"
        self.latest_date = "today"

    def generate_record(self):
        fake = Faker()
        date = fake.date_between(
            start_date=self.earliest_date, end_date=self.latest_date)
        date = date.strftime("%d/%m/%Y")
        size = random.randint(self.size_min, self.size_max)
        stuff_size = size / 100 * 0.2
        record = [self.id,
                  size,
                  self.pavilion_types[random.randint(
                      0, len(self.pavilion_types) - 1)],
                  bool(random.randint(0, 1)),
                  date,
                  int(stuff_size) + 1]

        self.id += 1

        return record
