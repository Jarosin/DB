import psycopg2

class ZooRepository:
    def __init__(self):
        try:
            self.__connection = psycopg2.connect(
                    database='zoo',
                    user='bmstu',
                    password='qwerty',
                    host='127.0.0.1',
                    port="5432")
            self.__connection.autocommit = True
            self.__cursor = self.__connection.cursor()
            self.table = []
            print("PostgreSQL connection opened\n")
        except Exception as ex:
            print("Error while connecting with PostgreSQL\n", ex)
            return

    def __del__(self):
        if self.__connection:
            self.__cursor.close()
            self.__connection.close()
            print("PostgreSQL connection closed\n")

    def __sql_executer(self, sql_query):
        try:
            self.__cursor.execute(sql_query)
        except Exception as err:
            print("Error while get query - PostgreSQL\n", err)
            return

        return sql_query

    # 1. Скалаярный запрос
    def get_animals_total(self):

        print("Вывести общее количество зверей")

        sql_query = \
            """
            Select COUNT(*)
            from animals;
            """
        if self.__sql_executer(sql_query) is not None:
             row = self.__cursor.fetchone()
             print("Результат: ", row[0])

             return row[0]

    # 2. Выполнить запрос с несколькими соединениями (JOIN)
    def get_animals_with_medicine(self):
        print("Вывести вид и возраст животных для которых есть свободное лекарство (максимум 20)")
        sql_query = \
            """
            SELECT animals.species, animals.age
            from animals JOIN (
                    SELECT items_to_animals.animal_id
                    FROM items_to_animals join (
                        select items.id
                        from items
                        where type = 'medicine') as medicine_table
                        on items_to_animals.id = medicine_table.id
                    WHERE items_to_animals.availability = TRUE
            ) as animals_with_items
            on animals.id = animals_with_items.animal_id
            LIMIT 20;
            """
        if self.__sql_executer(sql_query) is not None:
             self.table = self.__cursor.fetchall()

    # 3. Выполнить запрос с ОТВ(CTE) и оконными функциями
    def get_tall_animals_by_age(self):
        print("Вывести высоких животных отсортированных по весу")
        sql_query = \
            """
            WITH TallAnimals (id, species, height, weight, age)
            AS
            (
                SELECT id, species, height, weight, age
                FROM animals
                WHERE height > (SELECT AVG(height)
                                        from animals)
            )
            SELECT id, species, weight,
            rank() over(partition by species order by weight desc)
            FROM TallAnimals
            order by rank;
            """
        if self.__sql_executer(sql_query) is not None:
             self.table = self.__cursor.fetchall()

    # 4. Выполнить запрос к метаданным;
    def get_data_types(self, name_table):
        print("Вывести данные о типах атрибутах в таблице", name_table)
        sql_query = \
        """
        SELECT column_name, data_type
        FROM information_schema.columns
        WHERE table_name = \'%s\';
        """ %(name_table)

        if self.__sql_executer(sql_query) is not None:
             self.table = self.__cursor.fetchall()

    # 5 Вызвать скалярную функцию (написанную в третьей лабораторной работе);
    def get_avg_animal_age(self):
        print("Вернуть средний возраст среди животных.")
        sql_query = \
        """
        CREATE or replace function avg_age() returns decimal
        LANGUAGE sql
        as 'select avg(age) from animals';


        Select avg_age();
        """

        if self.__sql_executer(sql_query) is not None:
             self.table = self.__cursor.fetchall()

    # 6. Вызвать многооператорную или табличную функцию (написанную в третьей лабораторной работе);
    def get_old_animals(self, old_age):
        print("Вывести животных старше указанного количества лет.")
        sql_query = \
        """
        Create or replace function old_animals(old_age integer)
        returns table(id integer, age integer)
        as $$
            BEGIN
            return QUERY
                select animals.id, animals.age
                from animals
                where animals.age > old_age;
            end;
        $$ LANGUAGE plpgsql;

            Select * from old_animals(%d);
        """  %(old_age)

        if self.__sql_executer(sql_query) is not None:
             self.table = self.__cursor.fetchall()

    # 7. Вызвать хранимую процедуру (написанную в третьей лабораторной работе);
    def inflation_procedure(self, percent):
        print("Применить указанную инфляцию к предметам.")
        sql_query = \
        """
        Create or replace procedure add_inflation_to_cost(inflation_coeff numeric)
        as $$
            declare
            BEGIN
                UPDATE items
                set cost = cost * inflation_coeff;
            end;
        $$ LANGUAGE plpgsql;

        CALL add_inflation_to_cost(%d);

        Select id, cost from items;
        """ %(percent)

        if self.__sql_executer(sql_query) is not None:
             self.table = self.__cursor.fetchall()

    # 8. Вызвать системную функцию или процедуру;
    def system_functionc_call(self):
        print("Вызвать системную функцию для вывода имени текущей базы данных.")

        sql_query = \
        """
            -- Вызвать системную функцию.
            SELECT *
            FROM current_database();
        """

        if self.__sql_executer(sql_query) is not None:
             self.table = self.__cursor.fetchall()

    # 9. Создать таблицу в базе данных, соответствующую тематике БД;
    def create_table_item_to_aviary(self):
        print("Создать таблицу местонахождения предметов в вальерах")

        sql_query = \
        """
        DROP TABLE IF EXISTS item_to_aviary;
        CREATE TABLE IF NOT EXISTS item_to_aviary
        (
            id int PRIMARY KEY,
            aviary_id int REFERENCES aviary(id) on delete cascade,
            item_id int REFERENCES items(id) on delete cascade,
            is_movable bool
        );
        """

        if self.__sql_executer(sql_query) is not None:
            print("ОК")
        else:
            print("Error! Check Sql Query!")

    # 10. Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT или COPY
    def insert_item_to_aviary(self, id, item_id, aviary_id, is_movable):
        print("Вставка данных в таблицу item_to_aviary")
        sql_query = \
        """
        INSERT INTO item_to_aviary(id, item_id, aviary_id, is_movable)
        VALUES(%d, %d, %d, %r)
        """ %(id, item_id, aviary_id, is_movable)

        if self.__sql_executer(sql_query) is not None:
            print("ОК")
        else:
            print("Error! Check Sql Query!")

    def find_items_for_species(self, species, item_type):
        print("Вывести количество предметов данного типа и сумму их стоимостей, доступных для данного животного")
        sql_query = \
        """
            select count(*), sum(cost)
            from (select * from animals a
            join items_to_animals ita
            on ita.animal_id = a.id
            join items i
            on i.id = ita.item_id and type = '%s' and a.species = '%s') as res
            group by res.type;
        """ %(item_type, species)
        if self.__sql_executer(sql_query) is not None:
            self.table = self.__cursor.fetchall()

    def print_table(self):
        for r in self.table:
            print(r)
