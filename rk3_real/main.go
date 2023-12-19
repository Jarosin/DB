package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"os"

	_ "github.com/lib/pq"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

//go:generate go-bindata -pkg main -o sqlscripts.go ./sql

type AuthDB struct {
	Host     string
	Port     int
	Username string
	Password string
	DBName   string
	SSLMode  string
}

func recreate(sqlDB *sql.DB) error {
	script, err := Asset("sql/task1.sql")
	if err != nil {
		return err
	}

	_, err = sqlDB.Exec(string(script))

	return nil
}

func SQLquery1(sqlDB *sql.DB) error {
	script, err := Asset("sql/query1.sql")
	if err != nil {
		return err
	}

	rows, err := sqlDB.Query(string(script))
	if err != nil {
		return err
	}
	defer rows.Close()

	var name string

	for rows.Next() {
		err = rows.Scan(&name)
		if err != nil {
			return err
		}
		fmt.Println(name)
	}
	if err = rows.Err(); err != nil {
		return err
	}

	return nil
}

func SQLquery2(sqlDB *sql.DB) error {
	script, err := Asset("sql/query2.sql")
	if err != nil {
		return err
	}

	rows, err := sqlDB.Query(string(script))
	if err != nil {
		return err
	}
	defer rows.Close()

	var name string

	for rows.Next() {
		err = rows.Scan(&name)
		if err != nil {
			return err
		}
		fmt.Println(name)
	}
	if err = rows.Err(); err != nil {
		return err
	}

	return nil
}

func SQLquery3(sqlDB *sql.DB, date string) error {
	script, err := Asset("sql/query3.sql")
	if err != nil {
		return err
	}

	rows, err := sqlDB.Query(string(script))
	if err != nil {
		return err
	}
	defer rows.Close()

	var name string

	for rows.Next() {
		err = rows.Scan(&name)
		if err != nil {
			return err
		}
		fmt.Println(name)
	}
	if err = rows.Err(); err != nil {
		return err
	}

	return nil
}

func task1(sqlDB *sql.DB, date string) error {
	err := recreate(sqlDB)
	if err != nil {
		return err
	}

	fmt.Println("Найти самого старшего сотрудника в бухгалтерии")
	err = SQLquery1(sqlDB)
	if err != nil {
		return err
	}

	fmt.Println("Найти сотрудника, который пришел сегодня на работу раньше всех")
	err = SQLquery2(sqlDB)
	if err != nil {
		return err
	}

	fmt.Println("Найти сотрудника, который пришел сегодня последним")

	return SQLquery3(sqlDB, date)
}

func GORMquery1(gormDB *gorm.DB) error {
	subQuery := gormDB.Select("min(date_of_birth)").Table("employees").Where("department = 'FIN'")

	rows, err := gormDB.Select("name").Table("employees").Where("employees.date_of_birth = (?)", subQuery).Rows()
	if err != nil {
		return err
	}
	defer rows.Close()

	var name string

	for rows.Next() {
		err = rows.Scan(&name)
		if err != nil {
			return err
		}
		fmt.Println(name)
	}
	if err = rows.Err(); err != nil {
		return err
	}

	return nil
}

func GORMquery2(gormDB *gorm.DB) error {
	subQuery := gormDB.Select("min(times.time)").Table("times").Where("date = '2022-12-13' and times.type = '1'")

	rows, err := gormDB.Select("employees.name").Table("employees").Joins("join times on employee_id = employees.id").Where("date = '2022-12-13' and times.time = (?)", subQuery).Rows()
	if err != nil {
		return err
	}
	defer rows.Close()

	var name string

	for rows.Next() {
		err = rows.Scan(&name)
		if err != nil {
			return err
		}
		fmt.Println(name)
	}
	if err = rows.Err(); err != nil {
		return err
	}

	return nil
}

func GORMquery3(gormDB *gorm.DB, date string) error {
	subQuery := gormDB.Select("max(times.time)").Table("times").Where("date = '2022-12-13' and times.type = '1'")

	rows, err := gormDB.Select("employees.name").Table("employees").Joins("join times on employee_id = employees.id").Where("date = '2022-12-13' and times.time = (?)", subQuery).Rows()
	if err != nil {
		return err
	}
	defer rows.Close()

	var name string

	for rows.Next() {
		err = rows.Scan(&name)
		if err != nil {
			return err
		}
		fmt.Println(name)
	}
	if err = rows.Err(); err != nil {
		return err
	}

	return nil
}

func task2(gormDB *gorm.DB, date string) error {
	fmt.Println("Найти самого старшего сотрудника в бухгалтерии")
	err := GORMquery1(gormDB)
	if err != nil {
		return err
	}

	fmt.Println("Найти сотрудника, который пришел сегодня на работу раньше всех")
	err = GORMquery2(gormDB)
	if err != nil {
		return err
	}

	fmt.Println("Найти сотрудника, который пришел сегодня последним")

	return GORMquery3(gormDB, date)
}

func main() {
	data, err := os.ReadFile("AuthDB.json")
	if err != nil {
		panic(err)
	}

	var dbRequest AuthDB
	err = json.Unmarshal(data, &dbRequest)
	if err != nil {
		panic(err)
	}
	postgresInfo := fmt.Sprintf("host=%s port=%d user=%s password=%s dbname=%s sslmode=%s",
		dbRequest.Host, dbRequest.Port, dbRequest.Username, dbRequest.Password, dbRequest.DBName, dbRequest.SSLMode)
	sqlDB, err := sql.Open("postgres", postgresInfo)
	if err != nil {
		panic(err)
	}
	gormDB, err := gorm.Open(postgres.New(postgres.Config{Conn: sqlDB}), &gorm.Config{})
	if err != nil {
		panic(err)
	}

	var date string
	fmt.Print("Enter the date: ")
	_, err = fmt.Scanf("%s", &date)
	if err != nil {
		panic(err)
	}

	fmt.Println("==========================================GORM=========================================")
	err = task2(gormDB, date)
	if err != nil {
		panic(err)
	}

	fmt.Println("==========================================SQL==========================================")
	err = task1(sqlDB, date)
	if err != nil {
		panic(err)
	}

	err = sqlDB.Close()
	if err != nil {
		panic(err)
	}
}
