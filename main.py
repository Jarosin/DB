from db_manager import *
from json_parser import JsonParser
from generator.animal_generator import AnimalGenerator
from generator.animals_to_items_generator import ItemsToAnimalsGenerator
from generator.aviary_generator import AviaryGenerator
from generator.items_generator import ItemsGenerator

TABLE_ROOT = "tables/"
AMOUNT_OF_RECORDS = 1000

tables = ["create_aviary_table.sql", "create_animals_table.sql", "create_items_table.sql", "animals_items_table.sql"]
parser = JsonParser()
data = parser.read_json("DB.json")["databases"][0]
database = DBManager(data["name"], data["user"], data["password"], data["host"], data["port"])

for file_name in tables:
    file = open(TABLE_ROOT + file_name, "r")
    query = file.read()
    file.close()

    database.execute_query(query)

items_generator = ItemsGenerator()
aviary_generator = AviaryGenerator()
animals_generator = AnimalGenerator()
animals_to_items_generator = ItemsToAnimalsGenerator()
generators = [aviary_generator, animals_generator, items_generator, animals_to_items_generator]

for generator in generators:
    generator.fill_db(database.get_connection(), AMOUNT_OF_RECORDS)
