import pandas as pd

class DBWriter:
    def write_db(self, file_name, table_name, db_manager):
        df = pd.read_csv(file_name)
        df.to_sql(name=table_name, con=db_manager.get_engine(), if_exists='append', index=False)
