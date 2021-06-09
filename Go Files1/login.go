package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
)

var emorph string
var password string

type Logdat struct {
	Email    string `json:"Email"`
	Password string `json:"Password"`
}

func Loger() string {
	database, _ := sql.Open("sqlite3", "./petportal.db")
	var dumown Owners
	fmt.Println(emorph)
	rows, er := database.Query("SELECT owner_id,owner_name,owner_phno,email,password,Location,Device,Status FROM petowners where email =" + "'" + emorph + "'" + "ORDER BY owner_id DESC")
	fmt.Println(er)
	if er != nil {
		return "no"
	}
	for rows.Next() {
		rows.Scan(&dumown.Owner_id, &dumown.Owner_name, &dumown.Owner_phno, &dumown.Owner_email, &dumown.Owner_password, &dumown.Owner_location, &dumown.Owner_device, &dumown.Owner_status)
		//fmt.Println(dumown.Owner_password)
		if dumown.Owner_password == password {
			if dumown.Owner_status == "active" {
				fmt.Println("yes")
				rows.Close()
				database.Close()
				return "yes"
			}

		}

	}
	rows.Close()
	//mt.Println(rows)
	//fmt.Println(string(dumown.Owner_email))
	fmt.Println("the error is ")
	fmt.Println(er)
	database.Close()
	return "no"
}
func LogerV() string {
	database, _ := sql.Open("sqlite3", "./petportal.db")
	var dumven Vendor
	rows, er4 := database.Query("SELECT vendor_id,vendor_name,vendor_email,vendor_service_type,vendor_phn_no, vendor_license_no,vendor_password, vendor_location, vendor_status, vendor_device FROM vendor where vendor_email = " + "'" + emorph + "'" + "ORDER BY vendor_id DESC")
	fmt.Println(er4)
	if er4 != nil {
		return "no"
	}
	for rows.Next() {
		rows.Scan(&dumven.Vendor_id, &dumven.Vendor_name, &dumven.Vendor_email, &dumven.Vendor_service_type, &dumven.Vendor_phno, &dumven.Vendor_license, &dumven.Vendor_password, &dumven.Vendor_location, &dumven.Vendor_status, &dumven.Vendor_device)
		if dumven.Vendor_password == password {
			if dumven.Vendor_status == "active" {
				//fmt.Println("yes")
				database.Close()
				rows.Close()
				return "yes" + "," + dumven.Vendor_service_type
			}

		}
	}
	rows.Close()
	database.Close()
	defer database.Close()

	return "no"

}

func Login(respwr http.ResponseWriter, req *http.Request) {
	var data Logdat
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data)
	fmt.Println(data)
	fmt.Println(data.Email)
	emorph = data.Email
	password = data.Password
	fmt.Println(err)
	x := Loger()
	fmt.Println(x)
	defer req.Body.Close()
	respwr.Write([]byte(x))
	//defer req.Body.Close()

}
func LoginV(respwr http.ResponseWriter, req *http.Request) {
	var data Logdat
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data)
	fmt.Println(data)
	fmt.Println(data.Email)
	emorph = data.Email
	password = data.Password
	fmt.Println(err)
	x := LogerV()
	fmt.Println(x)
	defer req.Body.Close()
	respwr.Write([]byte(x))
	//defer req.Body.Close()

}
