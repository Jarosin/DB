from db_manager import *
from json_parser import JsonParser

TABLE_ROOT = "tables/"


tables = ["create_aviary_table.sql", "create_animals_table.sql", "create_items_table.sql", "animals_items_table.sql"]
parser = JsonParser()
data = parser.read_json("DB.json")["databases"][0]
database = DBManager(data["name"], data["user"], data["password"], data["host"], data["port"])

for file_name in tables:
    file = open(TABLE_ROOT + file_name, "r")
    query = file.read()
    file.close()

    database.execute_query(query)
