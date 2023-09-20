import psycopg2
from psycopg2 import OperationalError
from sqlalchemy import create_engine


class DBManager:
    def __init__(self, db_name, db_user, db_password, db_host, db_port) -> None:
        self.connection = self.__create_connection(
            db_name, db_user, db_password, db_host, db_port)
        self.db_name = db_name
        self.db_user = db_user
        self.db_password = db_password
        self.db_host = db_host
        self.db_port = db_port

    def get_engine(self):
        bd = f'postgresql://{self.db_user}:{self.db_password}@{self.db_host}:{self.db_port}/{self.db_name}'
        engine = create_engine(bd)
        return engine

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

    def get_connection(self):
        return self.connection

    def execute_query(self, query):
        self.connection.autocommit = True
        cursor = self.connection.cursor()
        try:
            cursor.execute(query)
            print("Query executed successfully")
        except OperationalError as e:
            print(f"The error '{e}' occurred")
