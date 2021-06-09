package main

import (
	//"database/sql"
	//"encoding/json"
	"database/sql"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	//"strconv"
	//"strings"

	_ "github.com/mattn/go-sqlite3"
)

type Review struct {
	Review_id    string `json:"Review_id"`
	Owner_id     string `json:"Owner_id"`
	Vendor_id    string `json:"Vendor_id"`
	Service_id   string `json:"Service_id"`
	Review_stars string `json:"Review_stars"`
	Review_text  string `json:"Review_text"`
	Owner_email  string `json:"Owner_email"`
	Vendor_email string `json:"Vendor_email"`
	//Owner_name   string `json:"Owner_name"`
	//Vendor_name  string `json:"Vendor_name"`
}

var review_stars string
var review_text string

func Addreview(respwr http.ResponseWriter, req *http.Request) {
	fmt.Println("hudo")
	database, er := sql.Open("sqlite3", "./petportal.db")
	var rev Review
	fmt.Println(er)
	statement, err := database.Prepare("CREATE TABLE IF NOT EXISTS review(review_id text Primary Key, owner_id text, vendor_id text, service_id text,review_stars text, review_text text, FOREIGN KEY (owner_id) REFERENCES petowners(owner_id), FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id), FOREIGN KEY (service_id) REFERENCES services(service_id))")
	fmt.Println(err)
	fmt.Println(statement)
	var z1 string
	var ven_mailr1 = "pratikgon012@gmail.com"
	var own_mailr1 = "gon.pratik@gmail.com"
	var ven_id string
	var own_id string
	var serv_id string
	rows1, er9 := database.Query("SELECT vendor_id  FROM vendor where vendor_email =" + "'" + ven_mailr1 + "';")
	for rows1.Next() {
		rows1.Scan(&ven_id)
	}
	fmt.Print(ven_id)
	fmt.Println("select vendor id error")
	fmt.Println(er9)

	rows2, er3 := database.Query("SELECT owner_id FROM petowners where email =" + "'" + own_mailr1 + "';")
	fmt.Println(er3)
	for rows2.Next() {
		fmt.Println("owner id")
		rows2.Scan(&own_id)
	}
	fmt.Print(own_id)
	fmt.Println("select vendor id error")

	rows3, er9 := database.Query("SELECT Service_id  FROM services where Vendor_id =" + "'" + ven_id + "';")
	for rows3.Next() {
		rows3.Scan(&serv_id)
	}
	fmt.Print(serv_id)
	fmt.Println("select vendor id error")
	fmt.Println(er9)

	temp := database.QueryRow("SELECT review_id, owner_id, vendor_id, service_id, review_stars, review_text FROM review ORDER BY review_id DESC")
	temp.Scan(&rev.Review_id, &rev.Owner_id, &rev.Vendor_id, &rev.Service_id, &rev.Review_stars, &rev.Review_text)
	if rev.Review_id != "" {
		fmt.Println("hi")
		x := strings.Split(rev.Review_id, "r")
		v, _ := strconv.Atoi(x[1])
		z1 = "r" + strconv.Itoa((v + 1))

		fmt.Println("the z is " + z1)
		//fmt.Println("the created id is " + z)
	}
	if rev.Review_id == "" {
		z1 = "r1"
	}
	fmt.Println("the z is " + z1)

	//rev = Review{Review_id:"r1", Owner_id: "o1", Vendor_id: "v1", Service_id: "s1", Review_stars: "3", Review_text:"testing"}

var rev1 Review
rev1 = Review{Review_id:z1, Owner_id: own_id, Vendor_id: ven_id, Service_id: serv_id , Review_stars: "3", Review_text:"testing"}
rev1.Review_id=z1
fmt.Println(rev1.Owner_id)
//var rev2 Review
statement1, er := database.Prepare("INSERT INTO review (review_id, owner_id, vendor_id, service_id, review_stars, review_text) VALUES (?, ?, ?, ?, ?, ?)")
fmt.Println(err)
x, y := statement1.Exec(rev1.Review_id, rev1.Owner_id, rev1.Vendor_id, rev1.Service_id, rev1.Review_stars, rev1.Review_text)
fmt.Println(x)
fmt.Println(y)
//statement1.Exec("r5","o5","v5","s5","3.0","test")
}
