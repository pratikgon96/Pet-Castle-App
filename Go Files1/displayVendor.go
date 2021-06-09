package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

type vendorDisp struct {
	Vendor_name         string `json:"Vendor_name"`
	Vendor_email        string `json:"Vendor_email"`
	Vendor_service_type string `json:"Vendor_service_type"`
	Vendor_phn_no       string `json:"Vendor_ph_no"`
	Vendor_location     string `json:"Vendor_location"`
	Vendor_license_no   string `json:"Vendor_license_no"`
}

func dispVendor(respwr http.ResponseWriter, req *http.Request) {

	keys, ok := req.URL.Query()["key"]

	if !ok || len(keys[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}

	database, e := sql.Open("sqlite3", "./petportal.db")
	fmt.Println(e)
	var data5 string
	fmt.Println("----------------------------------------------------------------------")
	fmt.Println("printing body")
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data5)
	fmt.Println(data5)
	//var emorph = data3
	//var ven_id string
	var obj vendorDisp
	//var objar []vendorDisp
	//fmt.Println(database)
	key := keys[0]

	var venMail = string(key)
	fmt.Println(venMail)

	// rows1, er9 := database.Query("SELECT vendor_id  FROM vendor where vendor_email = " + "'" + venMail + "';")
	// for rows1.Next() {
	// 	rows1.Scan(&ven_id)
	// }

	// fmt.Println(ven_id)
	// fmt.Println(er9)
	// rows1.Close()

	obj.Vendor_email = venMail
	fmt.Println(venMail)
	//venMail = data5.Vendor_email
	rows4, er3 := database.Query("SELECT vendor_name,vendor_email,vendor_service_type,vendor_phn_no, vendor_license_no, vendor_location FROM vendor where vendor_email = " + "'" + venMail + "';")
	fmt.Println(er3)
	for rows4.Next() {
		fmt.Println("Goku")
		rows4.Scan(&obj.Vendor_name, &obj.Vendor_email, &obj.Vendor_service_type, &obj.Vendor_phn_no, &obj.Vendor_license_no, &obj.Vendor_location)
		fmt.Println(obj)
		//objar = append(objar, obj)
	}

	fmt.Println("the object to send is ")
	//	fmt.Println(objar)
	fmt.Println(obj)
	fmt.Println(er3)
	rows4.Close()
	vendorJson, err := json.Marshal(obj)
	fmt.Println(err)
	database.Close()
	fmt.Println("-------------------------------------------------")
	respwr.Write([]byte(vendorJson))
	fmt.Println(vendorJson)

	fmt.Println(er3)
	defer req.Body.Close()
}
