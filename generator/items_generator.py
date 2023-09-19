from .base_generator import BaseGenerator
import random
from faker import Faker
import csv


class ItemsGenerator(BaseGenerator):
    def __init__(self) -> None:
        super().__init__()

        self.params = ["id", "cost", "weight", 'type', 'expiraton_data']

        self.cost_min = 0.2
        self.cost_max = 1500

        self.weight_min = 0.1
        self.weight_max = 500

        self.item_types = ["toy", "furniture", "treat", "medicine"]

        self.earliest_date = "-10y"
        self.latest_date = "today"

    def generate_record(self):
        fake = Faker()
        date = fake.date_between(
            start_date=self.earliest_date, end_date=self.latest_date)
        date = date.strftime("%d/%m/%Y")
        record = [self.id,
                            random.uniform(self.cost_min, self.cost_max),
                            random.uniform(self.weight_min,
                                        self.weight_max),
                            self.item_types[random.randint(
                                0, len(self.item_types) - 1)],
                            date]

        self.id += 1

        return record
