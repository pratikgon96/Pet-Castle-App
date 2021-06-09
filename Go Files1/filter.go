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
// }
type ret_filter struct {
	vend    []Vendor
	service []Services
}

func FilterStuff(startdate string, enddate string, location string, rating int, serv_type string) ([]Vendor, []Services) {
	//var dates []string
	//var samp_date string
	var ven_arr []Vendor
	var date string
	var status string
	var ser_type string
	var get_rating string
	var temp_serv string
	var temp_ven string
	//var temp_loc string
	//var retu []ret_filter
	var servi []Services

	database, _ := sql.Open("sqlite3", "./petportal.db")
	date_temp, _ := database.Query("SELECT review_stars,service_id FROM review  ORDER by review_id DESC")
	m := make(map[string]string)
	//m1 := make(map[string]string)
	for date_temp.Next() {
		date_temp.Scan(&get_rating, &temp_serv)
		m[temp_serv] = get_rating

	}
	date_temp2, _ := database.Query("SELECT vendor_id,service_id From services")
	for date_temp2.Next() {
		date_temp2.Scan(&temp_ven, &temp_serv)
		m[temp_ven] = temp_serv

	}
	var ven1 Vendor
	date_temp3, _ := database.Query("SELECT vendor_id,vendor_name,vendor_email,vendor_service_type,vendor_phn_no,vendor_location FROM vendor ORDER BY vendor_id DESC")
	for date_temp3.Next() {

		date_temp3.Scan(&ven1.Vendor_id, &ven1.Vendor_name, &ven1.Vendor_email, &ven1.Vendor_service_type, &ven1.Vendor_phno, &ven1.Vendor_location)
		if ven1.Vendor_location == location {
			ven_arr = append(ven_arr, ven1)
		}

	}
	var ser1 Services
	for p := 0; p < len(ven_arr); p++ {
		l := ven_arr[p].Vendor_id
		data_temp4, _ := database.Query("SELECT vendor_id,service_idservice_name from services where vendor_id = " + "'" + l + "'")
		for data_temp4.Next() {
			data_temp4.Scan(&ser1.Vendor_id, &ser1.Service_id, &ser1.Service_name)
			servi = append(servi, ser1)

		}

	}

	//fmt.Println("saima is a good girl")
	fmt.Println(m)

	z := "s1"
	date_temp1 := database.QueryRow("SELECT service_dates,service_status,service_type FROM services where service_id = " + "'" + z + "'")

	//fmt.Println("saima is hurt")
	date_temp1.Scan(&date, &status, &ser_type)
	date_arr := strings.Split(date, "--")
	fmt.Println(date_arr)

	//fmt.Println("////////  PRATIK    is the brightest thing in this code")
	fmt.Println(date_temp)

	/*for rows.Next() {
		rows.Scan(&date, &status)
		fmt.Println("date " + date + "status " + status)

	}*/
	return ven_arr, servi
}

// func main() {

// 	//fmt.Println(time.Now())
// 	FilterStuff("2021-02-21", "2021-02-23", "banglore", 5, "groomer")
// }
