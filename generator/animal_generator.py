from .base_generator import BaseGenerator
import random


class AnimalGenerator(BaseGenerator):
    def __init__(self, total_amount) -> None:
        super().__init__()
        self.total_amount = total_amount
        self.table_name = "animals"
        self.params = ['id', 'aviary_id', "species",
                       'weigth', 'heigh', 'endangered', 'age']

        self.names = ["wolve", "lion", "antelope", "beaver", "capybara",
                      "elephant", "squirrel", "horse", "goat", "cheetah", "zebra",
                      "fox", "goose", "hawk", "crab", "sealion",
                      "hedgehog", "mole", "duck", "baboon", "peacock",
                      "flamingo", "lynx", "owl", "wombat", "sheep", "bison",
                      "buffalo", "bull", "kangaroo", "bear", "camel", "rabbit",
                      "donkey", "deer", "tiger", "pig", "giraffe", "turtle"]

        self.weight_max = 2000
        self.weight_min = 0.01

        self.height_min = 10
        self.height_max = 320

        self.age_min = 1
        self.age_max = 100

    def set_total(self, total_amount):
        self.total_amount = total_amount


    def generate_record(self):
        weight = random.uniform(self.weight_min, self.weight_max)
        height = weight / 0.45
        record = [self.id,
                  random.randint(0, self.total_amount - 1),
                  self.names[random.randint(0, len(self.names) - 1)],
                  '%.3f'%(weight),
                  '%.3f'%(height),
                  bool(random.randint(0, 1)),
                  random.randint(self.age_min, self.age_max)]
        self.id += 1

        return record
