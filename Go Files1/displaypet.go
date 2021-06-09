package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

type PetDisp struct {
	Owner_name  string `json:"Owner_name"`
	Owner_email string `json:"Owner_email"`
	Onwer_phno  string `json:"Owner_phno"`
	Pet_id      string `json:"Pet_id"`
	Pet_name    string `json:"Pet_name"`
	Pet_breed   string `json:"Pet_breed"`
	Pet_DOB     string `json:"Pet_DOB"`
}

func DispPet(respwr http.ResponseWriter, req *http.Request) {

	database, _ := sql.Open("sqlite3", "./petportal.db")
	var data2 string
	fmt.Println("----------------------------------------------------------------------")
	fmt.Println("printing request body")
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data2)
	fmt.Println(data2)
	var emorph = data2
	var own_id string
	var obj PetDisp
	var objar []PetDisp
	//fmt.Println(database)
	var tempmail = data2
	fmt.Println(tempmail)
	//fmt.Println(emorph)
	rows1, er9 := database.Query("SELECT owner_id FROM petowners where email = " + "'" + tempmail + "';")
	fmt.Println("the error in owner_id ")
	fmt.Println(er9)
	for rows1.Next() {
		rows1.Scan(&own_id)
	}
	fmt.Println("the owner id  is ")

	fmt.Println(own_id)
	fmt.Println(er9)
	rows1.Close()
	obj.Owner_email = tempmail
	fmt.Println(tempmail)
	rows2, er3 := database.Query("SELECT pet_id,pet_name,pet_breed,pet_dob FROM pets where owner_id = " + "'" + own_id + "';")

	for rows2.Next() {
		rows2.Scan(&obj.Pet_id,&obj.Pet_name, &obj.Pet_breed, &obj.Pet_DOB)
		fmt.Println(obj)
		objar = append(objar, obj)

	}
	fmt.Println("the object to send is ")
	fmt.Println(objar)
	fmt.Println(er3)
	rows2.Close()
	servicesJson, err := json.Marshal(objar)
	fmt.Println(err)
	database.Close()
	fmt.Println("-------------------------------------------------")
	respwr.Write([]byte(servicesJson))
	fmt.Println(servicesJson)

	fmt.Println(er3)
	fmt.Println(emorph)
	defer req.Body.Close()
}
