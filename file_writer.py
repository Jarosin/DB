import csv

class FileWriter():
    def write_csv(self, filename, data):
        with open(filename, 'a', encoding="UTF8", newline='') as f:
            writer = csv.writer(f)
            writer.writerow(data)
        return

    def generate_csv(self, filename, amount_of_records, generator):
        self.write_csv(filename, generator.get_header())

        generator.reset_id()
        for i in range(amount_of_records):
            data = generator.generate_record()
            self.write_csv(filename, data)
