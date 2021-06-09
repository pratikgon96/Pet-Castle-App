package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

type Vendor struct {
	Vendor_id           string `json:"Vendor_id"`
	Vendor_name         string `json:"Vendor_name"`
	Vendor_email        string `json:"Vendor_email"`
	Vendor_service_type string `json:"Vendor_service_type"`
	Vendor_phno         string `json:"Vendor_phno"`
	Vendor_password     string `json:"Vendor_password"`
	Vendor_location     string `json:"Vendor_location"`
	Vendor_license      string `json:"Vendor_license"`
	Vendor_status       string `json:"Vendor_status"`
	Vendor_device       string `json:"Vendor_device"`
}

// type Vendor struct {
// 	Vendor_id           string
//  	Vendor_name         string
//  	Vendor_email        string
//  	Vendor_service_type string
// 	Vendor_phn_no       string
//  	Vendor_password     string
//  	Vendor_location     string
//  	Vendor_license_no   string
//  	Vendor_status       string
//  	Vendor_device       string
//  }

// type services struct {
// 	vendor_id        string
// 	service_id       string
// 	service_name     string
// 	service_price    string
// 	service_duration string
// 	service_status   string
// 	service_time     string
// 	service_dates    string
// 	service_images   string
// }
type Poster struct {
	Vendor_email  string `json:"Vendor_email"`
	Service_price string `json:"Service_price"`
	Service_name  string `json:"Service_name"`
}

var ven_mail string
var service_name string
var service_price string

func AddService(respwr http.ResponseWriter, req *http.Request) {
	//var whv string
	var date []string
	var date_string string
	for i := 0; i < len(date); i++ {
		date_string = date_string + "--" + date[i]
	}
	var result = "yes"
	//var who string
	fmt.Println("entering the get methods of services")
	//client := &http.Client{}
	var data Poster
	var ven_id string
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data)
	fmt.Println(data)
	fmt.Println("data feild")
	fmt.Println(data.Vendor_email)
	ven_mail = data.Vendor_email
	fmt.Println("ven_mail" + ven_mail)
	service_name = data.Service_name
	service_price = data.Service_price
	fmt.Println(err)

	database, er := sql.Open("sqlite3", "./petportal.db")
	fmt.Println("error opening database")
	fmt.Println(err)
	var serv Services
	var n string
	statement, er := database.Exec("CREATE TABLE IF NOT EXISTS services (vendor_id text, service_id text, service_name text, service_price text, service_duration text, service_status text, service_time text,service_dates,service_images,PRIMARY KEY (service_id),FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id));")
	fmt.Println("the error is ")
	fmt.Println(er)
	fmt.Println(statement)
	rows1, er9 := database.Query("SELECT vendor_id  FROM vendor where vendor_email =" + "'" + ven_mail + "';")
	for rows1.Next() {
		rows1.Scan(&ven_id)
	}
	rows1.Close()
	fmt.Println("vendor id is ")
	fmt.Print(ven_id)
	fmt.Println("select vendor id error")
	fmt.Println(er9)

	rows2, er3 := database.Query("SELECT service_name FROM services where vendor_id = " + "'" + ven_id + "';")
	fmt.Println(er3)
	for rows2.Next() {
		rows2.Scan(&serv.Service_name)
		fmt.Println(serv.Service_name)
		fmt.Println(service_name)
		if serv.Service_name == service_name {
			result = "no"

			respwr.Write([]byte(result))

			break

		}
	}
	rows2.Close()
	//y := database.Close()
	//fmt.Println(y)
	if result == "yes" {
		//database, er := sql.Open("sqlite3", "./petportal.db")
		fmt.Println("enteritng the result == yes")

		fmt.Println(er)
		temp := database.QueryRow("SELECT vendor_id ,service_id FROM services ORDER BY service_id DESC;")
		//fmt.Println("hello")
		temp.Scan(&serv.Vendor_id, &serv.Service_id)
		//temp.Close()
		fmt.Println("see what is there")
		fmt.Println("entering if")
		fmt.Println(serv.Vendor_id)
		fmt.Println(serv.Service_id)
		if serv.Service_id != "" {
			fmt.Println("hello hi see down")
			fmt.Println(serv.Service_id)
			x := strings.Split(serv.Service_id, "s")
			s, _ := strconv.Atoi(x[1])
			n = "s" + strconv.Itoa((s + 1))
		}

		fmt.Println("the n is ")
		if serv.Service_id == "" {
			n = "s1"
		}
		var serv1 Services
		var serv2 Services
		serv1 = Services{Vendor_id: ven_id, Service_id: n, Service_name: service_name, Service_price: service_price, Service_duration: ".25 hrs", Service_status: "active", Service_time: "08:30:00", Service_dates: date_string, Service_images: "http://link/link.jpg"}
		serv1.Service_id = n
		serv1.Vendor_id = ven_id
		fmt.Println("the vendor id is ")
		fmt.Println(serv1.Vendor_id)
		fmt.Println(serv1.Service_id)

		statement1, _ := database.Prepare("INSERT INTO services (vendor_id, service_id, service_name, service_price, service_duration, service_status,service_time,service_dates,service_images) VALUES (?, ?, ?, ?, ?, ?,?,?,?);")
		statement1.Exec(serv1.Vendor_id, serv1.Service_id, serv1.Service_name, serv1.Service_price, serv1.Service_duration, serv1.Service_status, serv1.Service_time, serv1.Service_dates, serv1.Service_images)
		// fmt.Println("y is ")
		// fmt.Println(y)
		// fmt.Println("x is ")
		// fmt.Println(x)
		//fmt.Println("Sword")

		rows, er2 := database.Query("SELECT vendor_id ,service_id , service_name , service_price , service_duration ,service_status ,service_time,service_dates FROM services ORDER BY service_id DESC;")
		fmt.Println(er2)

		for rows.Next() {
			//fmt.Println("Lightbringer")
			rows.Scan(&serv2.Vendor_id, &serv2.Service_id, &serv2.Service_name, &serv2.Service_price, &serv2.Service_duration, &serv2.Service_status, &serv2.Service_time, &serv2.Service_dates)
			fmt.Println("Its done : " + serv2.Vendor_id + " " + serv2.Service_id + " " + serv2.Service_dates)
		}
		rows.Close()
		database.Close()
		respwr.Write([]byte(result))

	}
	//result = "yes"

	//respwr.Write([]byte(result))
	database.Close()

	defer req.Body.Close()

}

func AddVendor(respwr http.ResponseWriter, req *http.Request) {
	database, s := sql.Open("sqlite3", "./petportal.db")
	fmt.Println(s)
	var ven Vendor //var z string
	var result = "yes"
	//var who string
	fmt.Println("entering the get methods of addvendor")
	//client := &http.Client{}
	var data Vendor
	fmt.Println(req.Body)
	dec := json.NewDecoder(req.Body)
	err := dec.Decode(&data)
	fmt.Println(data)
	fmt.Println(data.Vendor_name)
	fmt.Println(err)

	var mail string

	//var z string
	var whv string
	//whv = "v1"

	statement, _ := database.Prepare("CREATE TABLE IF NOT EXISTS vendor (vendor_id Text Primary Key, vendor_name Text, vendor_email Text, vendor_service_type Text, vendor_phn_no text, vendor_license_no Text, vendor_password text, vendor_location Text, vendor_status Text, vendor_device Text);")
	statement.Exec()
	//fmt.Println(er2, er2)
	temp2, er3 := database.Query("SELECT vendor_email FROM vendor;")
	fmt.Println(er3)
	for temp2.Next() {

		temp2.Scan(&mail)
		if data.Vendor_email == mail {

			result = "no"
			temp2.Close()
			database.Close()
			respwr.Write([]byte(result))

			break

		}

	}

	if result == "yes" {
		database, s := sql.Open("sqlite3", "./petportal.db")
		fmt.Println(s)
		temp := database.QueryRow("SELECT vendor_id,vendor_name,vendor_email,vendor_service_type,vendor_phn_no, vendor_license_no,vendor_password, vendor_location, vendor_status, vendor_device FROM vendor ORDER BY vendor_id DESC;")
		temp.Scan(&ven.Vendor_id, &ven.Vendor_name, &ven.Vendor_email, (&ven.Vendor_service_type), &ven.Vendor_phno, &ven.Vendor_password, &ven.Vendor_location, &ven.Vendor_license, &ven.Vendor_status, &ven.Vendor_device)
		fmt.Println("hi")
		if ven.Vendor_id != "" {

			x := strings.Split(ven.Vendor_id, "v")
			v, _ := strconv.Atoi(x[1])
			whv = "v" + strconv.Itoa((v + 1))

			//fmt.Println("the z is " + z)
			//fmt.Println("the created id is " + z)
		}

		if ven.Vendor_id == "" {
			whv = "v1"
		}
		//fmt.Println("Hell0")
		var ven1 Vendor
		var ven2 Vendor
		ven1 = Vendor{Vendor_id: whv, Vendor_name: data.Vendor_name, Vendor_email: data.Vendor_email, Vendor_service_type: data.Vendor_service_type, Vendor_phno: data.Vendor_phno, Vendor_license: data.Vendor_license, Vendor_password: data.Vendor_password, Vendor_location: data.Vendor_location, Vendor_status: "active", Vendor_device: data.Vendor_device}
		//fmt.Println("Hell")
		//ven1.Vendor_id = whv
		fmt.Println(ven1.Vendor_id)

		statement1, _ := database.Prepare("INSERT INTO vendor (vendor_id,vendor_name,vendor_email,vendor_service_type,vendor_phn_no,vendor_license_no,vendor_password, vendor_location, vendor_status, vendor_device) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);")
		x, y := statement1.Exec(ven1.Vendor_id, ven1.Vendor_name, ven1.Vendor_email, ven1.Vendor_service_type, ven1.Vendor_phno, ven1.Vendor_license, ven1.Vendor_password, ven1.Vendor_location, ven1.Vendor_status, ven1.Vendor_device)
		//fmt.Println("He")
		fmt.Println(y)
		fmt.Println(x)
		rows, _ := database.Query("SELECT vendor_id,vendor_name,vendor_email,vendor_service_type,vendor_phn_no, vendor_license_no,vendor_password, vendor_location, vendor_status, vendor_device FROM vendor ORDER BY vendor_id DESC;")
		//fmt.Println("Bone")
		for rows.Next() {
			//fmt.Println("Shard")
			rows.Scan(&ven2.Vendor_id, &ven2.Vendor_name, &ven2.Vendor_email, &ven2.Vendor_service_type, &ven2.Vendor_phno, &ven2.Vendor_license, &ven2.Vendor_password, &ven2.Vendor_location, &ven2.Vendor_status, &ven2.Vendor_device)
			//fmt.Println("Sword")
			fmt.Println(ven2)
			fmt.Println(ven2.Vendor_id + " " + ven2.Vendor_email + " " + ven2.Vendor_service_type)
		}
		rows.Close()
		database.Close()
		respwr.Write([]byte(result))

	}
	defer req.Body.Close()
	database.Close()
	//samp := []string{"2012-12-21", "2102-12-13"}
	//AddService(whv, samp)

}

// func main() {
// 	AddVendor("saima", "princess@fairytale.com", "veterinarian", "8097546312", "6788 AA 9087", "iamtopper", "PrincessCastle-fairyland", "active", "mangophone")
// }
