import psycopg2
from psycopg2 import OperationalError

class DBManager:
    def __init__(self, db_name, db_user, db_password, db_host, db_port) -> None:
        self.connection = self.__create_connection(db_name, db_user, db_password, db_host, db_port)

    def __create_connection(self, db_name, db_user, db_password, db_host, db_port):
        connection = None
        try:
            connection = psycopg2.connect(
                database=db_name,
                user=db_user,
                password=db_password,
                host=db_host,
                port=db_port,
            )
            print("Connection to PostgreSQL DB successful")
        except OperationalError as e:
            print(f"The error '{e}' occurred")
        return connection

    def __del__(self):
        self.connection.close()
