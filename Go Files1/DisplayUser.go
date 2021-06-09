package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

type ownerDisp struct {
	Owner_name     string `json:"Owner_name"`
	Owner_email    string `json:"Owner_email"`
	Owner_phno     string `json:"Owner_phno"`
	Owner_location string `json:"Owner_location"`
}

func dispOwner(respwr http.ResponseWriter, req *http.Request) {

	keys, ok := req.URL.Query()["key"]

	if !ok || len(keys[0]) < 1 {
		//log.Println("Url Param 'key' is missing")
		return
	}

	database, _ := sql.Open("sqlite3", "./petportal.db")
	var data3 string
	fmt.Println("----------------------------------------------------------------------")
	fmt.Println("printing req body")
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data3)
	var obj ownerDisp
	key := keys[0]
	//var objar []ownerDisp
	var tempmail = string(key)
	//var tempmail = "gon007@gmail.com"
	fmt.Println(tempmail)
	obj.Owner_email = tempmail
	fmt.Println(tempmail)
	rows2, er3 := database.Query("SELECT owner_name, email,owner_phno, Location FROM petowners where email = " + "'" + tempmail + "';")

	for rows2.Next() {
		//fmt.Println("vageta")
		rows2.Scan(&obj.Owner_name, &obj.Owner_email, &obj.Owner_phno, &obj.Owner_location)
		fmt.Println(obj)
		//objar = append(objar, obj)
	}

	fmt.Println("the object to send is ")
	//fmt.Println(objar)
	fmt.Println(obj)
	fmt.Println(er3)
	rows2.Close()
	OwnerJson, err := json.Marshal(obj)
	fmt.Println(err)
	database.Close()
	fmt.Println("-------------------------------------------------")
	respwr.Write([]byte(OwnerJson))
	fmt.Println(OwnerJson)

	fmt.Println(er3)
	//fmt.Println(emorph)
	defer req.Body.Close()
}
