package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	"time"

	_ "github.com/mattn/go-sqlite3"
)

type Owners struct {
	Owner_id       string `json:"Owner_id"`
	Owner_name     string `json:"Owner_name"`
	Owner_phno     string `json:"Owner_phno"`
	Owner_email    string `json:"Owner_email"`
	Owner_password string `json:"Owner_password"`
	Owner_location string `json:"Owner_location"`
	Owner_device   string `json:"Owner_device"`
	Owner_status   string `json:"Owner_status"`
}
type Pet struct {
	Owner_email string `json:"Owner_email"`
	Owner_id    string `json:"Owner_id"`
	Pet_id      string `json:"Pet_id"`
	Pet_name    string `json:"Pet_name"`
	Pet_DOB     string `json:"Pet_DOB"`
	Pet_breed   string `json:"Pet_breed"`
	Pet_image   string `json:"Pet_image"`
	Pet_status  string `json:"Pet_status"`
}

var own_mail string
var pet_name string
var pet_DOB string
var pet_breed string

func AddPet(respwr http.ResponseWriter, req *http.Request) {
	var result = "yes"
	fmt.Println("entering the get methods of add pet")
	var data Pet
	var own_id string
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data)
	fmt.Println(data)
	fmt.Println(data.Owner_email)
	own_mail = data.Owner_email
	fmt.Println("own_email" + own_mail)
	pet_name = data.Pet_name
	pet_DOB = data.Pet_DOB
	pet_breed = data.Pet_breed
	fmt.Println(err)

	database, _ := sql.Open("sqlite3", "./petportal.db")
	var pet2 Pet
	var z string
	//var name string

	statement, er := database.Exec("CREATE TABLE IF NOT EXISTS pets (owner_id text,pet_id text, pet_name text,pet_dob text,pet_breed text,pet_image text,pet_status text,PRIMARY KEY (pet_id),FOREIGN KEY (owner_id) REFERENCES owner(owner_id))")
	fmt.Println(er)
	fmt.Println(statement)
	rows1, er9 := database.Query("SELECT owner_id FROM petowners where email =" + "'" + own_mail + "';")
	for rows1.Next() {
		rows1.Scan(&own_id)
	}
	rows1.Close()
	fmt.Println("owner id is ")
	fmt.Print(own_id)
	fmt.Println("select owner id error")
	fmt.Println(er9)
	rows2, er3 := database.Query("SELECT pet_name FROM pets where owner_id = " + "'" + own_id + "';")
	fmt.Println(er3)
	for rows2.Next() {
		rows2.Scan(&pet2.Pet_name)
		fmt.Println(pet2.Pet_name)
		fmt.Println(pet_name)
		if pet2.Pet_name == pet_name {
			result = "no"

			respwr.Write([]byte(result))

			break

		}
	}
	rows2.Close()
	if result == "yes" {
		//database, er := sql.Open("sqlite3", "./petportal.db")
		fmt.Println("enteritng the result == yes")
		fmt.Println(er)
		temp := database.QueryRow("SELECT owner_id ,pet_id FROM pets ORDER BY pet_id DESC;")
		//fmt.Println("hello")
		temp.Scan(&pet2.Owner_id, &pet2.Pet_id)
		//temp.Close()
		fmt.Println("see what is there")
		fmt.Println("entering if")
		fmt.Println(pet2.Owner_id)
		fmt.Println(pet2.Pet_id)
		if pet2.Pet_id != "" {
			fmt.Println("hello hi see down")
			fmt.Println(pet2.Pet_id)
			x := strings.Split(pet2.Pet_id, "p")
			p, _ := strconv.Atoi(x[1])
			z = "p" + strconv.Itoa((p + 1))
		}

		fmt.Println("the n is ")
		if pet2.Pet_id == "" {
			z = "p1"
		}
		// tabler, _ := database.Query("SELECT name FROM sqlite_master WHERE type='table'")
		// for tabler.Next() {
		// 	tabler.Scan(&name)
		// 	fmt.Println(name)
		// 	fmt.Println(tabler.Columns())
		// }
		temp1 := database.QueryRow("SELECT owner_id,pet_id,pet_name,pet_dob,pet_breed,pet_image,pet_status FROM pets ORDER BY pet_id DESC")
		fmt.Println("hello")
		temp1.Scan(&pet2.Owner_id, &pet2.Pet_id, &pet2.Pet_name, &pet2.Pet_DOB, &pet2.Pet_breed, &pet2.Pet_image, &pet2.Pet_status)
		fmt.Println("the thing is " + pet2.Pet_id)
		if pet2.Pet_id != "" {

			x := strings.Split(pet2.Pet_id, "p")
			v, _ := strconv.Atoi(x[1])
			z = "p" + strconv.Itoa((v + 1))

			fmt.Println("the z is " + z)
			//fmt.Println("the created id is " + z)
		}
		if pet2.Pet_id == "" {
			z = "p1"
		}
		var pet1 Pet
		var pet3 Pet
		pet1 = Pet{Owner_id: own_id, Pet_id: z, Pet_name: pet_name, Pet_DOB: pet_DOB, Pet_breed: pet_breed, Pet_image: "SM-90121", Pet_status: "active"}
		pet1.Pet_id = z
		pet1.Owner_id = own_id
		fmt.Println("the owner id is ")
		fmt.Println(pet1.Owner_id)
		fmt.Println(pet1.Pet_id)

		statement1, _ := database.Prepare("INSERT INTO pets (owner_id,pet_id,pet_name,pet_dob,pet_breed,pet_image,pet_status) VALUES (?, ?, ?, ?, ?, ?, ?)")
		statement1.Exec(pet1.Owner_id, pet1.Pet_id, pet1.Pet_name, pet1.Pet_DOB, pet1.Pet_breed, pet1.Pet_image, pet1.Pet_status)
		//statement1.Exec("o1","p1","Bruno", "09.07.2000", "Dog", "xyz", "active")
		//fmt.Println(obj_own1.owner_id)
		//var obj_own2 Owner
		rows, _ := database.Query("SELECT owner_id,pet_id,pet_name,pet_dob,pet_breed,pet_image,pet_status FROM pets ORDER BY pet_id DESC", time.Now())
		//fmt.Println(x)
		for rows.Next() {
			rows.Scan(&pet3.Owner_id, &pet3.Pet_id, &pet3.Pet_name, &pet3.Pet_DOB, &pet3.Pet_breed, &pet3.Pet_image, &pet3.Pet_status)
			fmt.Println("Done : " + pet3.Owner_id + " " + pet3.Pet_id)
		}
		rows.Close()
		database.Close()
		respwr.Write([]byte(result))
	}
	database.Close()

	defer req.Body.Close()

}

func AddOwner(respwr http.ResponseWriter, req *http.Request) {
	var obj_own3 Owners
	//var z string
	var result = "yes"
	var who string
	fmt.Println("entering the get methods")
	//client := &http.Client{}
	var data Owners
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data)
	fmt.Println(data)
	fmt.Println(data.Owner_name)
	fmt.Println(err)

	var mail string

	database, _ := sql.Open("sqlite3", "./petportal.db")

	statement, _ := database.Prepare("CREATE TABLE IF NOT EXISTS petowners (owner_id TEXT PRIMARY KEY, owner_name TEXT, owner_phno TEXT,email TEXT,password TEXT,Location text,Device TEXT,Status TEXT)")
	statement.Exec()

	temp2, _ := database.Query("SELECT email FROM petowners")
	for temp2.Next() {

		temp2.Scan(&mail)

		if data.Owner_email == mail {

			result = "no"
			respwr.Write([]byte(result))

			defer req.Body.Close()
			database.Close()
			break
			//fmt.Println("nope")

		}

	}
	fmt.Println("the email thing in the data is ")
	fmt.Println(data.Owner_email)
	//statement, _ = database.Prepare("INSERT INTO petowners (owner_id,owner_name,email,password,Location,Device,Status) VALUES (?, ?, ?, ?, ?, ?, ?)")
	if result == "yes" {
		fmt.Println("entering the result ")
		temp := database.QueryRow("SELECT owner_id FROM petowners ORDER BY owner_id DESC")
		fmt.Println("hello")
		temp.Scan(&obj_own3.Owner_id)
		if obj_own3.Owner_id != "" {

			x := strings.Split(obj_own3.Owner_id, "o")
			v, _ := strconv.Atoi(x[1])
			who = "o" + strconv.Itoa((v + 1))
			//fmt.Println(z)
			//fmt.Println("the created id is " + z)
		}
		if obj_own3.Owner_id == "" {
			who = "o1"
		}
		var obj_own1 Owners
		obj_own1 = Owners{Owner_id: who, Owner_name: data.Owner_name, Owner_phno: data.Owner_phno,Owner_email: data.Owner_email, Owner_password: data.Owner_password, Owner_location: data.Owner_location, Owner_device: data.Owner_device, Owner_status: "active"}
		obj_own1.Owner_id = who
		fmt.Println()
		//fmt.Println("hi")
		statement, er2 := database.Prepare("INSERT INTO petowners (owner_id,owner_name,owner_phno,email,password,Location,Device,Status) VALUES (?, ?, ?,?, ?, ?, ?, ?)")
		statement.Exec(obj_own1.Owner_id, obj_own1.Owner_name, obj_own1.Owner_phno, obj_own1.Owner_email, obj_own1.Owner_password, obj_own1.Owner_location, obj_own1.Owner_device, obj_own1.Owner_status)
		//statement.Exec("o1","Pratik", "8967763126", "email@gmail.com", "password", "Burdwan", "OnePlus", "Active")
		//fmt.Println(obj_own1.owner_id)
		fmt.Println("the problem with insert statement ")
		fmt.Print(er2)
		var obj_own2 Owners
		rows, _ := database.Query("SELECT owner_id,owner_name,owner_phno,email,password,Location,Device,Status FROM petowners ORDER BY owner_id DESC", time.Now())
		//fmt.Println(x)
		for rows.Next() {
			rows.Scan(&obj_own2.Owner_id, &obj_own2.Owner_name, &obj_own2.Owner_phno, &obj_own2.Owner_email, &obj_own2.Owner_password, &obj_own2.Owner_location, &obj_own2.Owner_device, &obj_own2.Owner_status)
			fmt.Println(obj_own2.Owner_id + ": " + obj_own2.Owner_email + " " + obj_own2.Owner_status + " " + obj_own2.Owner_password)
		}
		fmt.Println("done")
		respwr.Write([]byte(result))
		database.Close()
		//AddPet(who)
	}
	defer req.Body.Close()

	//fmt.Println(time.Now().Clock())

}

// func main() {
// 	//AddOwner()

// }
