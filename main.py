from db_manager import *
from file_writer import *
from json_parser import JsonParser
from generator import *

TABLE_ROOT = "tables/"
AMOUNT_OF_RECORDS = 1000

tables = ["create_aviary_table.sql", "create_animals_table.sql",
          "create_items_table.sql", "animals_items_table.sql"]
parser = JsonParser()
data = parser.read_json("DB.json")["databases"][0]
database = DBManager(data["name"], data["user"],
                     data["password"], data["host"], data["port"])

CSV_FOLDER = "csv_files/"
csv_names = ["aviaries.csv", "animals.csv", "items.csv", "animals_to_items.csv"]

# for file_name in tables:
#     file = open(TABLE_ROOT + file_name, "r")
#     query = file.read()
#     file.close()

#     database.execute_query(query)

items_generator = items_generator.ItemsGenerator()
aviary_generator = aviary_generator.AviaryGenerator()
animals_generator = animal_generator.AnimalGenerator(AMOUNT_OF_RECORDS)
animals_to_items_generator = animals_to_items_generator.ItemsToAnimalsGenerator(
    AMOUNT_OF_RECORDS)
generators = [aviary_generator, animals_generator,
              items_generator, animals_to_items_generator]

writer = FileWriter()
for i in range(len(generators)):
    writer.generate_csv(CSV_FOLDER + csv_names[i], AMOUNT_OF_RECORDS, generators[i])
