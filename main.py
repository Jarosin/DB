from db_manager import *
from json_parser import JsonParser

parser = JsonParser()
data = parser.read_json("DB.json")["databases"][0]
DB = DBManager(data["name"], data["user"], data["password"], data["host"], data["port"])
