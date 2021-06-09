package main

import (
	"database/sql"

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
// }

func SearchWhatEv(cheese string) []Vendor {

	var ven2 Vendor
	var venarr []Vendor
	database, _ := sql.Open("sqlite3", "./petportal.db")
	rows, _ := database.Query("SELECT vendor_id,vendor_name,vendor_email,vendor_service_type,vendor_phn_no, vendor_license_no, vendor_location, vendor_status, vendor_device FROM vendor ORDER BY vendor_id DESC")
	//fmt.Println("Bone")
	for rows.Next() {
		//fmt.Println("Shard")
		rows.Scan(&ven2.Vendor_id, &ven2.Vendor_name, &ven2.Vendor_email, &ven2.Vendor_service_type, &ven2.Vendor_phno, &ven2.Vendor_license, &ven2.Vendor_location, &ven2.Vendor_status, &ven2.Vendor_device)
		venarr = append(venarr, ven2)
	}

	return venarr

}
