package main

import (
	"database/sql"
	"fmt"
	"strconv"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

type payment struct {
	payment_id     string
	owner_id       string
	vendor_id      string
	booking_id     string
	payment_price  string
	payment_status string
}

func seepayment(who string, whv string, differ string) {
	var temp_bookid string
	var temp_payment string
	var temp_price string
	database, _ := sql.Open("sqlite3", "./petportal.db")
	//database.Exec("DROP TABLE payment")
	statement, _ := database.Prepare("CREATE TABLE IF NOT EXISTS payment(payment_id Text Primary Key, owner_id Text, vendor_id Text, booking_id Text, payment_price Text, payment_status text, FOREIGN KEY (owner_id) REFERENCES petowners(owner_id), FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id), FOREIGN KEY (booking_id) REFERENCES booking(booking_id))")
	statement.Exec()
	//fmt.Println(x)
	//fmt.Println(y)
	var z string
	temp2 := database.QueryRow("SELECT payment_id FROM payment ORDER BY payment_id DESC")
	temp2.Scan(&temp_payment)
	//fmt.Println(whv)

	temp3 := database.QueryRow("SELECT booking_id,booking_totalprice FROM booking  WHERE vendor_id = " + "'" + whv + "'" + "ORDER BY booking_id DESC")
	fmt.Println(temp3)
	temp3.Scan(&temp_bookid, &temp_price)
	fmt.Println("the booking id is " + temp_bookid)
	fmt.Println(temp_price)
	if temp_payment != "" {

		x := strings.Split(temp_payment, ",")
		//help := strings.Split(x[0], "")
		//fmt.Println("the x is " + x)
		help2 := strings.Split(x[1], "p")
		//fmt.Println(help2)
		//fmt.Println(help)
		//fmt.Println(help2)
		//v, _ := strconv.Atoi(help[1])
		u, _ := strconv.Atoi(help2[1])
		//fmt.Println(u)
		if differ == "o" {

			z = who + "--" + whv + "," + "p" + strconv.Itoa((u + 1))
		}
		if differ == "v" {
			z = whv + "--" + who + "," + "p" + strconv.Itoa((u + 1))
		}

		//fmt.Println("the z is " + z)
		//fmt.Println("the created id is " + z)
	}
	if temp_payment == "" {
		if differ == "o" {
			z = "o1--v1,p1"
		}
		if differ == "v" {
			z = "v1--o1,p1"

		}
	}
	//temp := database.QueryRow("SELECT booking_id,booking_price FROM booking ORDER BY booking_id DESC  where booking_id = " + "'" + temp_bookid + "'")
	//temp.Scan(&temp_bookid, &temp_price)

	var pay payment
	pay = payment{payment_id: z, owner_id: who, vendor_id: whv, booking_id: temp_bookid, payment_price: temp_price, payment_status: "active"}
	tempo, _ := database.Prepare("INSERT INTO payment (payment_id,owner_id,vendor_id,booking_id,payment_price,payment_status) VALUES (?,?,?,?,?,?)")
	tempo.Exec(pay.payment_id, pay.owner_id, pay.vendor_id, pay.booking_id, pay.payment_price, pay.payment_status)
	rows, _ := database.Query("SELECT payment_id,owner_id,vendor_id,booking_id,payment_price,payment_status from payment")
	for rows.Next() {
		rows.Scan(&pay.payment_id, &pay.owner_id, &pay.vendor_id, &pay.payment_price, &pay.payment_status)
		fmt.Println(pay.payment_id + " : " + pay.payment_price)
	}
	database.Close()
}
// func main() {
// 	seepayment("o1", "v1", "o")
// 	fmt.Println("Payment is done ")
// 	Addnotification("o1", "v1", "v")
// 	//database, _ := sql.Open("sqlite3", "./petportal.db")

// 	//fmt.Println(time.Now().Date())

// }
// // 