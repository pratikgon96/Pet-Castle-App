package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

func DispServ(respwr http.ResponseWriter, req *http.Request) {

	database, _ := sql.Open("sqlite3", "./petportal.db")
	var data2 string
	fmt.Println("printing request body")
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data2)
	fmt.Println(data2)
	var emorph = data2
	var ven_id string
	var obj Poster
	var objar []Poster
	//fmt.Println(database)
	var tempmail = data2
	fmt.Println(tempmail)
	//fmt.Println(emorph)
	rows1, er9 := database.Query("SELECT vendor_id  FROM vendor where vendor_email = " + "'" + tempmail + "';")
	for rows1.Next() {
		rows1.Scan(&ven_id)
	}

	fmt.Println(ven_id)
	fmt.Println(er9)
	rows1.Close()
	obj.Vendor_email = tempmail
	fmt.Println(tempmail)
	rows2, er3 := database.Query("SELECT service_name,service_price FROM services where vendor_id = " + "'" + ven_id + "';")
	for rows2.Next() {
		rows2.Scan(&obj.Service_name, &obj.Service_price)
		fmt.Println(obj)
		objar = append(objar, obj)

	}
	fmt.Println(er3)
	rows2.Close()
	servicesJson, err := json.Marshal(objar)
	fmt.Println(err)
	database.Close()

	respwr.Write([]byte(servicesJson))
	fmt.Println(servicesJson)

	fmt.Println(er3)
	fmt.Println(emorph)
	defer req.Body.Close()
}

//
