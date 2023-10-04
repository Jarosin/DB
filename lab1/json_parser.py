import json

class JsonParser:
    def read_json(self, json_name):
        file = open(json_name)
        if not file:
            print("Something went wrong, cant read json")
            return 1
        data = json.load(file)
        print("Json read successfully")
        file.close()
        return data
