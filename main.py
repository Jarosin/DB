from db_manager import *
from file_writer import *
from json_parser import JsonParser
from generator import *
from db_writer import *

TABLE_ROOT = "tables/"
create_table_file_name = "tables.sql"
constraints_file_name = "constraints.sql"
copy_file_name = "copy.sql"
AMOUNT_OF_RECORDS = 1000

parser = JsonParser()
data = parser.read_json("DB.json")["databases"][0]
database_manager = DBManager(data["name"], data["user"],
                             data["password"], data["host"], data["port"])

CSV_FOLDER = "csv_files/"
csv_names = ["aviaries.csv", "animals.csv",
             "items.csv", "items_to_animals.csv"]


items_generator = items_generator.ItemsGenerator()
aviary_generator = aviary_generator.AviaryGenerator()
animals_generator = animal_generator.AnimalGenerator(AMOUNT_OF_RECORDS)
items_to_animals = items_to_animals_generator.ItemsToAnimalsGenerator(
    AMOUNT_OF_RECORDS)
generators = [aviary_generator, animals_generator,
              items_generator, items_to_animals]

help = """g - to generate data in csv files
c - to create tables
a - alter table to add constraints
w - to write data from csv into database
q - to end the process\n"""

while (1):
    command = input("Input a command:\n" + help)
    if command == 'c':
        file = open(TABLE_ROOT + create_table_file_name, "r")
        query = file.read()
        file.close()
        database_manager.execute_query(query)

    if command == 'a':
        file = open(TABLE_ROOT + constraints_file_name, "r")
        query = file.read()
        file.close()
        database_manager.execute_query(query)


    elif command == 'g':
        writer = FileWriter()
        for i in range(len(generators)):
            writer.generate_csv(
                CSV_FOLDER + csv_names[i], AMOUNT_OF_RECORDS, generators[i])

    elif command == 'w':
        file = open(TABLE_ROOT + copy_file_name, "r")
        query = file.read()
        file.close()
        database_manager.execute_query(query)
    elif command == 'q':
        break
