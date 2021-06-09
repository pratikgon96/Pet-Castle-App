package main

import (
	"database/sql"
	"fmt"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

// type vendor struct {
// 	vendor_id           string
// 	vendor_name         string
// 	vendor_email        string
// 	vendor_service_type string
// 	vendor_phn_no       string
// 	vendor_password     string
// 	vendor_location     string
// 	vendor_license_no   string
// 	vendor_status       string
// 	vendor_device       string
// }

// type services struct {
// 	vendor_id        string
// 	service_id       string
// 	service_name     string
// 	service_price    string
// 	service_duration string
// 	service_status   string
// 	service_time     string
// 	service_dates    string
// // 

func disable(date_arr []string) {
	//var dates []string
	//var samp_date string
	var date string
	var status string
	database, _ := sql.Open("sqlite3", "./petportal.db")
	z := "s1"
	rows, _ := database.Query("SELECT service_dates,service_status FROM services where service_id = " + "'" + z + "'")
	for rows.Next() {
		rows.Scan(&date, &status)
		fmt.Println("date " + date + "status " + status)

	}
	//fmt.Println("hi")
	date_temp := strings.Split(date, "--")
	for i := 1; i < len(date_temp); i++ {
		for j := 0; j < len(date_arr); j++ {
			if date_temp[i] == date_arr[j] && status == "active" {
				date_temp[i] = "0"
				//x, _ := database.Exec("UPDATE services SET service_status= " + "'" + "inactive" + "'" + "where service_id = " + "'" + "s1" + "'")
				//fmt.Println(x)

			}
		}
	}
	fmt.Println(date_temp)
	var changed_dates string
	for k := 1; k < len(date_temp); k++ {
		if (date_temp[k]) != "0" {
			changed_dates = changed_dates + "--" + date_temp[k]

		}

	}
	x, _ := database.Exec("UPDATE services SET service_dates= " + "'" + changed_dates + "'" + "where service_id = " + "'" + z + "'")
	fmt.Println(x)
	rows1 := database.QueryRow("SELECT service_dates,service_status FROM services where service_id = " + "'" + z + "'")
	rows1.Scan(&date, &status)
	fmt.Println(date + " : " + status)
	//fmt.Println("hello")
	fmt.Println(changed_dates)
}

func enable(data_arr []string) {
	database, _ := sql.Open("sqlite3", "./petportal.db")
	z := "s1"
	var date string
	var status string
	rows, _ := database.Query("SELECT service_dates,service_status FROM services where service_id = " + "'" + z + "'")
	for rows.Next() {
		rows.Scan(&date, &status)
		fmt.Println("date " + date + "status " + status)

	}
	var changed_dates string
	for k := 0; k < len(data_arr); k++ {
		changed_dates = changed_dates + "--" + data_arr[k]

	}
	x, _ := database.Exec("UPDATE services SET service_dates= " + "'" + changed_dates + "'" + "where service_id = " + "'" + z + "'")
	fmt.Println(x)
	rows1 := database.QueryRow("SELECT service_dates,service_status FROM services where service_id = " + "'" + z + "'")
	rows1.Scan(&date, &status)
	fmt.Println(date + " : " + status)
	//fmt.Println("hello")
	fmt.Println(changed_dates)

}
// func main() {
// 	x := []string{"2012-12-21", "2021-02-22"}
// 	disable(x)
// 	enable(x)
// 	//fmt.Println(time.Now())
// 	//FilterStuff("2021-02-21", "2021-02-23", "banglore", 5, "groomer")
// }
