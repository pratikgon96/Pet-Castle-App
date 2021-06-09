package main

import (
	"database/sql"
	//"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

// type editVen struct {
// 	Vendor_name         string `json:"Vendor_name"`
// 	Vendor_email        string `json:"Vendor_email"`
// 	Vendor_service_type string `json:"Vendor_service_type"`
// 	Vendor_phn_no       string `json:"Vendor_ph_no"`
// 	Vendor_location     string `json:"Vendor_location"`
// 	Vendor_license_no   string `json:"Vendor_license_no"`
// }
func editVenDisp(respwr http.ResponseWriter, req *http.Request) {

	keys, ok := req.URL.Query()["key"]
	if !ok || len(keys[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}

	keys1, ok := req.URL.Query()["key1"]

	if !ok || len(keys1[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}
	keys2, ok := req.URL.Query()["key2"]

	if !ok || len(keys1[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}
	keys3, ok := req.URL.Query()["key3"]

	if !ok || len(keys1[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}

database, e := sql.Open("sqlite3", "./petportal.db")
fmt.Println(e)
	key := keys[0]
	key1 := keys1[0]
	key2 := keys2[0]
	key3 := keys3[0]
	var venMail = string(key)
	var venName = string(key1)
	fmt.Println(venMail)
	var venPhn = string(key2)
	var venLocation = string(key3)
	fmt.Println(venName)
	fmt.Println(venPhn)
	// var data5 editVen
	// fmt.Println("----------------------------------------------------------------------")
	// fmt.Println("printing body")
	// fmt.Println(req.Body)
	// dec := json.NewDecoder(req.Body)
	// err := dec.Decode(&data5)
	// fmt.Println(data5.Vendor_email)
	// //var emorph = data3
	// //var own_id string
	// var obj editVen
	// //var objar []ownerDisp
	// //fmt.Println(database)
	// var venMail = data5.Vendor_email

	// obj.Vendor_email = venMail
	// fmt.Println(venMail)
	// venMail = "prat@gmail.com"
	// fmt.Println(venMail)
	stmt, err := database.Prepare("Update vendor set vendor_name=?, vendor_phn_no=?, vendor_location=?  where vendor_email=?")
	fmt.Println(err)
	result, err1:= stmt.Exec(venName, venPhn, venLocation, venMail)
	fmt.Println(err1)
	affect, err2 := result.RowsAffected()
	fmt.Println(affect)
	fmt.Println(result)
	fmt.Println(err2)
	// rows4, er3 := database.Query("SELECT vendor_name,vendor_email,vendor_service_type,vendor_phn_no, vendor_license_no, vendor_location FROM vendor where vendor_email = " + "'" + venMail + "';")
	// fmt.Println(er3)
	// for rows4.Next() {
	// 	fmt.Println("Goku")
	// 	rows4.Scan(&obj.Vendor_name, &obj.Vendor_email, &obj.Vendor_service_type, &obj.Vendor_phn_no, &obj.Vendor_license_no, &obj.Vendor_location)
	// 	fmt.Println(obj)
	// 	//objar = append(objar, obj)
	// }

	// fmt.Println("the object to send is ")
	// //fmt.Println(objar)
	// fmt.Println(obj)
	// fmt.Println(er3)
	// rows4.Close()
	// vendorJson, err := json.Marshal(obj)
	// fmt.Println(err)
	database.Close()
	// fmt.Println("-------------------------------------------------")
	// respwr.Write([]byte(vendorJson))
	// fmt.Println(vendorJson)

	// fmt.Println(er3)
	defer req.Body.Close()
}