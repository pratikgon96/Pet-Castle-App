package main

import (
	"database/sql"
	"fmt"
	"strconv"
	"strings"

	_ "github.com/mattn/go-sqlite3"
)

type Booking struct {
	Booking_id         string
	Owner_id           string
	Vendor_id          string
	Service_id         string
	Pet_id             string
	Booking_status     string
	Booking_totalprice string
	Booking_timestamp  string
	Booking_text       string
}

func AddBooking(who string, whv string, whp string, whse string) {
	database, _ := sql.Open("sqlite3", "./petportal.db")
	statement, _ := database.Prepare("CREATE TABLE IF NOT EXISTS booking (booking_id Text Primary Key, owner_id Text, vendor_id Text, service_id Text, pet_id text, booking_status Text, booking_totalprice text, booking_timestamp Text, booking_text Text, FOREIGN KEY (owner_id) REFERENCES petowners(owner_id), FOREIGN KEY (vendor_id) REFERENCES vendor(vendor_id), FOREIGN KEY (service_id) REFERENCES services(service_id), FOREIGN KEY (pet_id) REFERENCES pets(pet_id))")
	statement.Exec()
	var bok Booking
	var serid string
	var serpr string
	var z string
	temp := database.QueryRow("SELECT booking_id, owner_id, vendor_id, service_id, pet_id, booking_status, booking_totalprice, booking_timestamp, booking_text FROM booking ORDER BY booking_id DESC")
	temp.Scan(&bok.Booking_id, &bok.Owner_id, &bok.Vendor_id, &bok.Service_id, &bok.Pet_id, &bok.Booking_status, &bok.Booking_totalprice, &bok.Booking_timestamp, &bok.Booking_text)
	if bok.Booking_id != "" {

		x := strings.Split(bok.Booking_id, "b")
		v, _ := strconv.Atoi(x[1])
		z = "b" + strconv.Itoa((v + 1))

		fmt.Println("the z is " + z)
		//fmt.Println("the created id is " + z)
	}
	if bok.Booking_id == "" {
		z = "b1"
	}
	var strs []string
	var booking_price int
	var k int
	fmt.Println(bok.Service_id)
	strs = strings.Split(bok.Service_id, ",")
	fmt.Println(strs)
	for k = 0; k < len(strs); k++ {

		temp1, _ := database.Query("SELECT service_id, service_price FROM services WHERE service_id = " + "'" + strs[k] + "'")
		for temp1.Next() {
			temp1.Scan(&serid, &serpr)
			fmt.Println("the output: ", serid)
			fmt.Println("the service price is; " + serpr)
			h, _ := strconv.Atoi(serpr)
			fmt.Println(strs[k])
			fmt.Println(h)
			booking_price += h
		}
	}
	var bok1 Booking
	var bok2 Booking
	bookings := strconv.Itoa(booking_price)
	bok1 = Booking{Booking_id: z, Owner_id: who, Vendor_id: whv, Service_id: whse, Pet_id: whp, Booking_status: "active", Booking_totalprice: bookings, Booking_timestamp: "XXXXXX", Booking_text: "Additional allergy"}
	bok.Booking_id = z
	fmt.Println(bok.Booking_id)

	statement1, _ := database.Prepare("INSERT INTO booking (booking_id, owner_id, vendor_id, service_id, pet_id, booking_status, booking_totalprice, booking_timestamp, booking_text) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)")
	x, y := statement1.Exec(bok1.Booking_id, bok1.Owner_id, bok1.Vendor_id, bok1.Service_id, bok1.Pet_id, bok1.Booking_status, bok1.Booking_totalprice, bok1.Booking_timestamp, bok1.Booking_text)
	fmt.Println(y)
	fmt.Println(x)
	rows, _ := database.Query("SELECT booking_id, owner_id, vendor_id, service_id, pet_id, booking_status, booking_totalprice, booking_timestamp, booking_text FROM booking ORDER BY booking_id DESC")
	for rows.Next() {
		//fmt.Println("Shard")
		rows.Scan(&bok2.Booking_id, &bok2.Owner_id, &bok2.Vendor_id, &bok2.Service_id, &bok2.Pet_id, &bok2.Booking_status, &bok2.Booking_totalprice, &bok2.Booking_timestamp, &bok2.Booking_text)
		fmt.Println(bok2.Booking_id + " " + bok2.Owner_id + " " + bok2.Vendor_id + " " + bok2.Service_id + " " + bok2.Pet_id + " " + bok2.Booking_status + " " + bok2.Booking_totalprice + " " + bok2.Booking_timestamp + " " + bok2.Booking_text)
		//fmt.Println("Sword")
	}
	database.Close()
}
// func main() {
// 	database, _ := sql.Open("sqlite3", "./petportal.db")
// 	database.Close()
// 	AddBooking("o1", "v1", "p1", "s1,s2")
// 	//fmt.Println(time.Now().Date())

// }
