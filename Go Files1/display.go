package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"

	_ "github.com/mattn/go-sqlite3"
)

// type Vendor struct {
// 	Vendor_id           string `json:"Vendor_id"`
// 	Vendor_name         string `json:"Vendor_name"`
// 	Vendor_email        string `json:"Vendor_email"`
// 	Vendor_service_type string `json:"Vendor_service_type"`
// 	Vendor_phn_no       string `json:"Vendor_ph_no"`
// 	Vendor_password     string `json:"Vendor_password"`
// 	Vendor_location     string `json:"Vendor_location"`
// 	Vendor_license_no   string `json:"Vendor_license_no"`
// 	Vendor_status       string `json:"Vendor_status"`
// 	Vendor_device       string `json:"Vendor_device"`
// }
// type Review struct {
// 	Review_id    string `json:Review_id"`
// 	Owner_id     string `json:"Owner_id"`
// 	Vendor_id    string `json:"Vendor_id"`
// 	Service_id   string `json:"Service_id"`
// 	Review_stars string `json:"Review_stars"`
// 	Review_text  string `json:"Review_text"`
// }

type Display struct {
	Vendor_name    string `json:"Vendor_name"`
	Service_name   string `json:"Service_name"`
	Review_stars   string `json:"Review_stars"`
	Review_count   string `json:"Review_count"`
	Service_images string `json:"Service_images"`
}
type Services struct {
	Vendor_id        string `json:"Vendor_id"`
	Service_id       string `json:"Service_id"`
	Service_name     string `json:"Service_name"`
	Service_price    string `json:"Service_price"`
	Service_duration string `json:"Service_duration"`
	Service_status   string `json:"Service_status"`
	Service_time     string `json:"Service_time"`
	Service_dates    string `json:"Service_dates"`
	Service_images   string `json:"Service_images"`
}

func DisplayDoc(respwr http.ResponseWriter, req *http.Request) {
	database, er3 := sql.Open("sqlite3", "./petportal.db")
	fmt.Println("database open error")
	fmt.Println(er3)
	var serv2 Services
	var rev Review
	var vendarr []Vendor
	//var servarr []Services
	//var revarr []Review
	var dispar []Display
	var disp Display
	var listserv string
	var vend Vendor

	//var toDisplay []Display
	//var Display1 Display
	//var revcount stringvar vend Vendor
	fmt.Println("The error from select vendor details is ")

	rowsv, er1 := database.Query("SELECT vendor_id,vendor_name,vendor_email,vendor_service_type,vendor_phn_no, vendor_license_no,vendor_password, vendor_location, vendor_status, vendor_device FROM vendor ORDER BY vendor_id DESC;")
	fmt.Println(er1)

	for rowsv.Next() {
		rowsv.Scan(&vend.Vendor_id, &vend.Vendor_name, &vend.Vendor_email, &vend.Vendor_service_type, &vend.Vendor_phno, &vend.Vendor_license, &vend.Vendor_password, &vend.Vendor_location, &vend.Vendor_status, &vend.Vendor_device)
		fmt.Println("the vendor is ")
		fmt.Println(vend)
		if (vend.Vendor_status) == "active" {
			fmt.Println("before checking service type")
			fmt.Println(vend)
			if vend.Vendor_service_type == "Doctor" {
				fmt.Println("afte service check")
				vendarr = append(vendarr, vend)

			}
		}

	}
	fmt.Println("the vendarr with doctors")
	fmt.Println(vendarr)
	rowsv.Close()
	var i int
	for i = 0; i < len(vendarr); i++ {
		fmt.Println("vendor id inside for loop")
		fmt.Println(vendarr[i].Vendor_id)
		rows1, er9 := database.Query("SELECT service_id,service_name  FROM services where vendor_id =" + "'" + vendarr[i].Vendor_id + "';")
		fmt.Println("The error from selecting services")
		fmt.Println(er9)
		for rows1.Next() {
			rows1.Scan(&serv2.Service_id, &serv2.Service_name)
			listserv = "," + serv2.Service_name

		}
		disp.Vendor_name = vendarr[i].Vendor_name
		disp.Service_name = listserv
		rows1.Close()
		rows2, er10 := database.Query("SELECT review_stars FROM review where vendor_id =" + "'" + vendarr[i].Vendor_id + "';")
		fmt.Println("The error from selecting review is ")
		fmt.Println(er10)
		for rows2.Next() {
			rows2.Scan(&rev.Review_stars)
		}
		disp.Review_stars = rev.Review_stars
		dispar = append(dispar, disp)

	}
	database.Close()
	displayJson, err := json.Marshal(dispar)
	fmt.Println("the error in json conversion ")
	fmt.Println(err)
	fmt.Println(dispar)
	database.Close()
	fmt.Println("-------------------------------------------------")
	fmt.Println(displayJson)
	respwr.Write([]byte(displayJson))
	//fmt.Println("The object being sent it ")

	//fmt.Println(er3)
	//fmt.Println(emorph)
	defer req.Body.Close()

	//rowss, _ := database.Query("SELECT service_id,service_name FROM services where vendor_id = " + "'" + vendarr[i] + "'")
	// rows, er2 := database.Query("SELECT vendor_id text,service_id text, service_name text, service_price text, service_duration text,service_status Text FROM services ORDER BY service_id DESC")
	// //fmt.Println(x)
	// fmt.Println("The error getting services is ")
	// fmt.Println(er2)
	// for rows.Next() {
	// 	//fmt.Println("Lightbringer")
	// 	rows.Scan(&serv2.Vendor_id, &serv2.Service_id, &serv2.Service_name, &serv2.Service_price, &serv2.Service_duration, &serv2.Service_status)
	// 	servarr = append(servarr, serv2)

	// }
	// rows.Close()
	// rowsr, er2 := database.Query("SELECT review_id,owner_id,vendor_id , service_id, review_stars,review_text FROM review  ")
	// fmt.Println(er2)
	// for rowsr.Next() {
	// 	rows.Scan(&rev.Review_id, &rev.Owner_id, &rev.Vendor_id, &rev.Service_id, &rev.Review_stars, &rev.Review_text)
	// 	revarr = append(revarr, rev)

	// }
	// rowsr.Close()
	// var noven = len(vendarr)
	// var noserv = len()

	// database.Close()

}

//func main() {
//	http.HandleFunc("/hello", DisplayDoc)
//	http.ListenAndServe(":8090", nil)

//}
