from tp_db import ZooRepository

MSG = "\n\t\tМеню\n\n"\
      "\t1. Выполнить скалярный запрос \n"\
      "\t2. Выполнить запрос с несколькими соединениями (JOIN) \n"\
      "\t3. Выполнить запрос с ОТВ(CTE) и оконными функциями \n"\
      "\t4. Выполнить запрос к метаданным \n"\
      "\t5. Вызвать скалярную функцию \n"\
      "\t6. Вызвать многооператорную табличную функцию \n"\
      "\t7. Вызвать хранимую процедуру \n"\
      "\t8. Вызвать системную функцию \n"\
      "\t9. Создать таблицу в базе данных, соответствующую тематике БД \n"\
      "\t10. Выполнить вставку данных в созданную таблицу с использованием инструкции INSERT \n"\
      "\t0. Выход \n\n"\
      "\tВыбор: "\

def input_command():
    try:
        command = int(input(MSG))
        print()
    except:
        command = -1

    if command < 0 or command > 10:
        print("\nОжидался ввод целого чилово числа от 0 до 10")

    return command

def main():
    db_tp = ZooRepository()
    command = -1

    while command != 0:
        command = input_command()

        if command == 1:
            db_tp.get_animals_total()

        elif command == 2:
            db_tp.get_animals_with_medicine()

        elif command == 3:
            db_tp.get_tall_animals_by_age()

        elif command == 4:
            table = input("Введите название таблицы:")
            db_tp.get_data_types(table)

        elif command == 5:
            db_tp.get_avg_animal_age()

        elif command == 6:
            db_tp.get_old_animals(50)

        elif command == 7:
            db_tp.inflation_procedure(10)

        elif command == 8:
            db_tp.system_functionc_call()

        elif command == 9:
            db_tp.create_table_item_to_aviary()

        elif command == 10:
            print("Ввод данных для item_to_aviary")
            id = int(input("id: "))
            item_id = int(input("item_id: "))
            aviary_id = int(input("aviary_id: "))
            is_movable = bool(input("is_movable: "))
            db_tp.insert_item_to_aviary(id, item_id, aviary_id, is_movable)
        else:
            continue

        db_tp.print_table()


if __name__ == "__main__":
    main()
