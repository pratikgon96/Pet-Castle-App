package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

type editPet struct {
	Owner_email string `json:"Owner_email"`
	Owner_id    string `json:"Owner_id"`
	Pet_id      string `json:"Pet_id"`
	Pet_name    string `json:"Pet_name"`
	Pet_DOB     string `json:"Pet_DOB"`
	Pet_breed   string `json:"Pet_breed"`
	Pet_image   string `json:"Pet_image"`
}

var petName string
var petDOB string
var petBreed string
var petId string


func editPetDisp(respwr http.ResponseWriter, req *http.Request) {
	var result = "yes"
	var own_mail string
	fmt.Println("entering the get methods of edit pet")
	var data editPet
	var epet editPet
	var own_id string
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data)
	fmt.Println(data)
	fmt.Println(data.Pet_id)
	fmt.Println(data.Owner_email)
	own_mail = data.Owner_email
	fmt.Println("own_email is:" + own_mail)
	petName = data.Pet_name
	petDOB = data.Pet_DOB
	petBreed = data.Pet_breed
	petId = data.Pet_id
	fmt.Println(petId)
	fmt.Println(petName)
	fmt.Println(err)

	database, _ := sql.Open("sqlite3", "./petportal.db")
	rows1, er9 := database.Query("SELECT owner_id FROM petowners where email =" + "'" + own_mail + "';")
	for rows1.Next() {
		rows1.Scan(&own_id)
	}
	rows1.Close()
	fmt.Println("owner id is in edit:")
	fmt.Print(own_id)
	fmt.Println("select error")
	fmt.Println(er9)
	rows2, er3 := database.Query("SELECT pet_name FROM pets where owner_id = " + "'" + own_id + "';")
	fmt.Println(er3)
	for rows2.Next() {
		rows2.Scan(&epet.Pet_name)
		fmt.Println(epet.Pet_name)
		if epet.Pet_name == petName {
			result = "no"

			respwr.Write([]byte(result))

			break

		}
	}
	rows2.Close()
	if result == "yes" {
		fmt.Println("entering into edit")
	stmt, er1 := database.Prepare("Update pets set pet_name=?,pet_dob=?, pet_breed=? where pet_id=?")

	fmt.Println(er1)
	res, err := stmt.Exec(petName,petBreed,petDOB,petId)
	fmt.Println(err)
	affect, err := res.RowsAffected()
	fmt.Println(affect)
	fmt.Println(res)
	respwr.Write([]byte(result))
	}
	database.Close()
	defer req.Body.Close()
}