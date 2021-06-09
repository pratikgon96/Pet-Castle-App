package main

import (
	"database/sql"
	//"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)


func changePassword(respwr http.ResponseWriter, req *http.Request) {

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

	key := keys[0]
	key1 := keys1[0]
	database, _ := sql.Open("sqlite3", "./petportal.db")
	var tempmail = string(key)
	var tempPass = string(key1)
	fmt.Println(tempmail)
	//var result1 = "yes"
	//fmt.Println("data")
	//var data4 editOwner
	//var own_id string
	// fmt.Println(req.Body)
	// dec := json.NewDecoder(req.Body)
	// err := dec.Decode(&data4)
	// fmt.Println(data4)
	// fmt.Println(data4.Owner_email)
	// fmt.Println(err)
	stmt, err := database.Prepare("Update petowners set password=?  where email=?")
	fmt.Println(err)
	res, err := stmt.Exec(tempPass, tempmail)

	affect, err1 := res.RowsAffected()
	fmt.Println(affect)
	fmt.Println(res)
	fmt.Println(err1)
	database.Close()
	defer req.Body.Close()
}