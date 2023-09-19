from .base_generator import BaseGenerator
import random

class ItemsToAnimalsGenerator(BaseGenerator):
    def __init__(self, amount_of_records) -> None:
        super().__init__()
        self.params = ['id', 'animal_id', 'item_id','availability']
        self.amount_of_records = amount_of_records

    def set_total_amount(self, amount_of_records):
        self.amount_of_records = amount_of_records

    def generate_record(self):
        record = (self.id,
                random.randint(0, self.amount_of_records - 1),
                random.randint(0, self.amount_of_records - 1),
                bool(random.randint(0, 1)))
        return record
