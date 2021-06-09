package main

import (
	"database/sql"
	//"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

// type editOwner struct {
// 	Owner_id    string    `json:"Owner_id"`
// 	Owner_name     string `json:"Owner_name"`
// 	Owner_phno     string `json:"Owner_phno"`
// 	Owner_email    string `json:"Owner_email"`
// 	Owner_location string `json:"Owner_location"`
// }

var own_mail1 string

func editOwnerDisp(respwr http.ResponseWriter, req *http.Request) {
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

	database, _ := sql.Open("sqlite3", "./petportal.db")
	//var result1 = "yes"
	// fmt.Println("data")
	// var data4 editOwner
	// //var own_id string
	// fmt.Println(req.Body)
	// dec := json.NewDecoder(req.Body)
	// err := dec.Decode(&data4)
	// fmt.Println(data4)
	// fmt.Println(data4.Owner_email)
	// fmt.Println(err)
	//var obj editOwner
	//var tempmail = data4.Owner_email
	key := keys[0]
	key1 := keys1[0]
	key2 := keys2[0]
	key3 := keys3[0]
	var tempmail = string(key)
	stmt, _ := database.Prepare("Update petowners set owner_name=?,owner_phno=?, Location=?  where email=?")

	//checkErr(err)

	res, err := stmt.Exec(key1, key2, key3,tempmail)
	//res, err := stmt.Exec(data4.Owner_name, data4.Owner_phno, data4.Owner_location, tempmail)
fmt.Println(err)
	affect, err := res.RowsAffected()
	fmt.Println(affect)
	fmt.Println(res)

	// rows2, _ := database.Query("SELECT owner_name, email,owner_phno, Location FROM petowners where email = " + "'" + tempmail + "';")
	
	
	// for rows2.Next() {
	// 	rows2.Scan(&obj.Owner_name, &obj.Owner_email, &obj.Owner_phno, &obj.Owner_location)
	// 	fmt.Println(obj)
	// 	//objar = append(objar, obj)
	// }

	// fmt.Println(obj)
	// rows2.Close()
	// OwnerJson, err := json.Marshal(obj)
	// fmt.Println(err)
	database.Close()
	// fmt.Println("-------------------------------------------------")
	// respwr.Write([]byte(OwnerJson))
	// fmt.Println(OwnerJson)
	defer req.Body.Close()
}