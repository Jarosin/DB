class BaseGenerator:
    def __init__(self) -> None:
        self.params = []

        self.id = 0

    def reset_id(self):
        self.id = 0

    def get_header(self):
        return self.params

    def generate_record(self):
        return self.params

    def generate_insert(self):
        record = "INSERT INTO {self.table_names} ("
        for i in range(len(self.params)):
            record += self.params
            if i < len(self.params) - 1:
                record += ','

        record += ') VALUES('
        for i in range(len(self.params)):
            record += '?'
            if i < len(self.params) - 1:
                record += ','
        record += ")"
